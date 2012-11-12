require 'spec_helper'

describe PagesController do
  describe :show do
    before(:each) do
      Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = false
        config.multisite_config = []
      end
      Spud::Cms.configure do |config|
        config.enable_full_page_caching = false
      end
    end
    it "should render a page" do
      page = FactoryGirl.create(:spud_page)
      get :show ,:id => page.url_name
      assigns(:layout).should render_template(:layout => "layouts/#{Spud::Cms.default_page_layout}")
      response.should be_success
    end

    it "should render home page if id is blank" do
      page = FactoryGirl.create(:spud_page,:name => "home")
      get :show
      assigns(:page).should == page
      response.should be_success
    end

    it "should redirect to new page url from old page url if it was changed" do
      page = FactoryGirl.create(:spud_page,:name => "about")
      page.name = "about us"
      page.save

      get :show, :id => "about"

     response.should redirect_to page_url(:id => "about-us")

    end



    it "should not allow access to private pages when logged out" do
      page = FactoryGirl.create(:spud_page,:name => "about",:visibility => 1)

      get :show, :id => "about"
      response.should redirect_to new_spud_user_session_url()
    end

    describe "page caching" do
      before(:each) do
        Spud::Cms.configure do |config|
          config.enable_full_page_caching = false
        end
      end


    end

    describe "authorized login" do
       before(:each) do
        activate_authlogic
        u = SpudUser.new(:login => "testuser",:email => "test@testuser.com",:password => "test",:password_confirmation => "test")
        u.super_admin = true
        u.save
        @user = SpudUserSession.create(u)
      end

      it "should allow access to private pages when logged in" do
        page = FactoryGirl.create(:spud_page,:name => "about",:visibility => 1)

        get :show, :id => "about"
        response.should be_success
      end
    end

    describe "multisite enabled" do
        before(:each) do
          Spud::Core.configure do |config|
            config.site_name = "Test Site"
            config.multisite_mode_enabled = true
            config.multisite_config = [{:hosts => ["test.host"], :site_name =>"Site B", :site_id => 1}]
          end
        end

        it "should not show a page on a different site" do
          page = FactoryGirl.create(:spud_page,:name => "about",:site_id => 0)
          get :show,:id=>"about"
          response.response_code.should == 404
        end

        it "should show the right page" do
          page = FactoryGirl.create(:spud_page,:name => "about",:site_id => 0)
          page2 = FactoryGirl.create(:spud_page,:name => "about",:site_id => 1)
          get :show,:id=>"about"
          assigns(:page).should == page2
        end

        it "should return the homepage of the current site" do
          page = FactoryGirl.create(:spud_page,:name => "home",:site_id => 0)
          page_site1 = FactoryGirl.create(:spud_page,:name => "home",:site_id => 1)

          get :show
          assigns(:page).should == page_site1
        end

    end
  end
end
