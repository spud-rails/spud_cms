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

  describe :create do
    it "should create a new menu with a valid form submission" do
      lambda {
        post :create, :spud_menu => FactoryGirl.attributes_for(:spud_menu).reject{|k,v| k == 'site_id' || k == 'id'}
      }.should change(SpudMenu,:count).by(1)
      response.should be_redirect
    end

    it "should not create a menu with an invalid form entry" do
      lambda {
        post :create, :spud_menu => FactoryGirl.attributes_for(:spud_menu,:name => nil).reject{|k,v| k == 'site_id' || k == 'id'}
      }.should_not change(SpudMenu,:count)


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

      response.should redirect_to spud_core.admin_menus_url
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
      response.should redirect_to spud_core.admin_menus_url
    end

  end

  describe :update do
    it "should update the name when the name attribute is changed" do
      menu = FactoryGirl.create(:spud_menu)
      new_name = 'MyMenu'
      lambda {
        put :update,:id => menu.id, :spud_menu => menu.attributes.merge!(:name => new_name).reject{|k,v| k == 'site_id' || k == 'id'}
        menu.reload
      }.should change(menu,:name).to(new_name)

    end

    it "should redirect to the admin menus after a successful update" do
      menu = FactoryGirl.create(:spud_menu)
      put :update,:id => menu.id,:spud_menu => menu.attributes.merge!(:name => "MyMenu").reject{|k,v| k == 'site_id' || k == 'id'}

      response.should redirect_to(spud_core.admin_menu_menu_items_url(:menu_id => menu.id))
    end
  end

  describe :destroy do
    it "should destroy the menu" do
      menu = FactoryGirl.create(:spud_menu)
      lambda {
        delete :destroy, :id => menu.id
      }.should change(SpudMenu,:count).by(-1)
      response.should be_redirect
    end

    it "should not destroy the menu with a wrong id" do
      menu = FactoryGirl.create(:spud_menu)
      lambda {
        delete :destroy,:id => "23532"
      }.should_not change(SpudMenu,:count)
      response.should be_redirect
    end

  end
end
