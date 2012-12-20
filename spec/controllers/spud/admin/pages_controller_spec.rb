require 'spec_helper'

describe Spud::Admin::PagesController do
  before(:each) do
    activate_authlogic
    u = SpudUser.new(:login => "testuser",:email => "test@testuser.com",:password => "test",:password_confirmation => "test")
    u.super_admin = true
    u.save
    @user = SpudUserSession.create(u)
  end

  describe :index do
    it "should return an array of parent pages" do
      2.times {|x|  s = FactoryGirl.create(:spud_page)}
      get :index, :use_route => :spud_core

      assigns(:pages).count.should be > 1
    end

    it "should only return parent pages" do
      2.times {|x| FactoryGirl.create(:spud_page) }
      FactoryGirl.create(:spud_page,:spud_page_id => 1)

      get :index, :use_route => :spud_core
      assigns(:pages).count.should == 2
    end
  end

  describe :show do
    it "should respond successfully" do
      p = FactoryGirl.create(:spud_page)
      get :show, :use_route => :spud_core ,:id => p.id
      assigns(:layout).should render_template(:layout => "layouts/#{Spud::Cms.default_page_layout}")
      response.should be_success
    end



    # it "should redirect if no id specified" do
    #   get :show,:id => nil

    #   response.should redirect_to spud_core.admin_pages_url
    # end

  end

  describe :new do
    it "should respond successfully" do
      get :new

      response.should be_success
    end

    it "should build a page object for the form" do
      get :new

      assigns(:page).should_not be_blank
    end
  end

  describe :edit do
    context "HTML format" do
      it "should load the correct page for the edit form" do
        page = FactoryGirl.create(:spud_page)
        get :edit, :id => page.id

        assigns(:page).id.should == page.id
      end
    end

  end


  describe :update do
    it "should update the name when the attribute is changed" do
      page = FactoryGirl.create(:spud_page)
      new_name = "Adam"
      lambda {
        put :update, :id => page.id, :spud_page => page.attributes.merge!(:name => new_name).reject{ |key,value| key == 'id' || key == 'created_at' || key == 'updated_at' || key == 'site_id'}
        page.reload
      }.should change(page, :name).to(new_name)
    end

    it "should redirect to the page root index after a successful update" do
      page = FactoryGirl.create(:spud_page)
      new_name = "Adam"
      put :update, :id => page.id, :spud_page => page.attributes.merge!(:name => new_name).reject{ |key,value| key == 'id' || key == 'created_at' || key == 'updated_at' || key == 'site_id'}

      response.should redirect_to(spud_core.admin_pages_url)
    end
  end

  describe :destroy do
    it "should destroy the page" do
      page = FactoryGirl.create(:spud_page)
      lambda {
        delete :destroy, :id => page.id
      }.should change(SpudPage, :count).by(-1)
      response.should be_redirect
    end

    it "should destroy the user with the wrong id" do
      page = FactoryGirl.create(:spud_page)
      lambda {
        delete :destroy, :id => "23532"
      }.should_not change(SpudPage, :count)
      response.should be_redirect
    end
  end

end
