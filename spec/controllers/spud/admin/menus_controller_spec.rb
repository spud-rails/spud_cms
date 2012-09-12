require 'spec_helper'

describe Spud::Admin::MenusController do
  before(:each) do
    activate_authlogic
    u = SpudUser.new(:login => "testuser",:email => "test@testuser.com",:password => "test",:password_confirmation => "test")
    u.super_admin = true
    u.save
    @user = SpudUserSession.create(u)
    Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = false
        config.multisite_config = []
    end
  end


  describe :index do
    it "should return an array of menus" do
      2.times {|x|  s = FactoryGirl.create(:spud_menu)}
      get :index

      assigns(:menus).count.should be > 1
    end

  end

  describe :new do
    it "should response with new menu" do
      get :new
      assigns(:menu).should_not be_blank
      response.should be_success
    end
  end

  describe :multisite do
    before(:each) do
      Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = true
        config.multisite_config = [{:hosts => ["test.host"], :site_name =>"Site B", :site_id => 1}]
      end

    end
    it "should not allow editing of a menu on a different site id" do
      menu2 = FactoryGirl.create(:spud_menu,:site_id => 1)
      get :edit,:id => menu2.id

      response.should redirect_to spud_admin_menus_url
    end
  end

  describe :edit do
    it "should response with menu by id" do
      menu1 = FactoryGirl.create(:spud_menu)
      menu2 = FactoryGirl.create(:spud_menu)
      get :edit,:id => menu2.id
      assigns(:menu).should == menu2
    end
    it "should redirect to index if menu not found" do
      get :edit,:id => 3
      response.should redirect_to spud_admin_menus_url
    end

  end
end
