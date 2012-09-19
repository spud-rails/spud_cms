require 'spec_helper'

describe Spud::Admin::MenuItemsController do
  before(:each) do
    ActiveRecord::Base.observers.disable(:page_sweeper)

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

    @menu = FactoryGirl.create(:spud_menu)
  end


  describe :index do
    it "should return an array of menus" do
      2.times {|x|  s = FactoryGirl.create(:spud_menu_item,:spud_menu_id => @menu.id,:parent_id => @menu.id)}
      get :index,:menu_id =>@menu.id

      assigns(:menu_items).count.should be > 1
    end
  end

  describe :new do
    it "should assign a new menu" do
      get :new,:menu_id =>@menu.id
      assigns(:menu_item).should_not be_blank
      response.should be_success
    end
  end

  describe :create do
    it "should create a new menu item with a valid form submission" do
      lambda {
        post :create,:menu_id => @menu.id, :spud_menu_item => FactoryGirl.attributes_for(:spud_menu_item).reject{|k,v| k == 'id' || k == :spud_menu_id}
      }.should change(SpudMenuItem,:count).by(1)
      response.should be_redirect
    end

    it "should not create a menu item with an invalid form entry" do
      yamldata = FactoryGirl.attributes_for(:spud_menu_item,:name => nil).reject{|k,v| k == 'id' || k == :spud_menu_id}

      lambda {
        post :create,:menu_id => @menu.id, :spud_menu_item => FactoryGirl.attributes_for(:spud_menu_item,:name => nil).reject{|k,v| k == 'id' || k == :spud_menu_id}
      }.should_not change(SpudMenuItem,:count)


    end
  end

  describe :edit do
    it "should respond with menu item by id" do
      menu1 = FactoryGirl.create(:spud_menu_item)
      menu2 = FactoryGirl.create(:spud_menu_item)
      get :edit, :menu_id => @menu.id,:id => menu2.id
      assigns(:menu_item).should == menu2
    end

    it "should redirect_to index if menu item not found" do
      get :edit,:menu_id => @menu.id,:id => "345"
      response.should redirect_to spud_admin_menu_menu_items_url(:menu_id => @menu.id)
    end
  end

  describe :update do
    it "should update the name when the name attribute is changed" do
      menu_item = FactoryGirl.create(:spud_menu_item,:parent_id => @menu.id)
      new_name = 'MyMenu'
      lambda {
        put :update,:menu_id => @menu.id,:id => menu_item.id, :spud_menu_item => menu_item.attributes.merge!(:name => new_name).reject{|k,v| k.to_sym == :spud_menu_id || k == 'id' || k.to_sym == :updated_at || k.to_sym == :created_at}
        menu_item.reload
      }.should change(menu_item,:name).to(new_name)

    end
  end


  describe :destroy do
    it "should destroy the menu item" do
      menu_item = FactoryGirl.create(:spud_menu_item,:parent_id => @menu.id)
      lambda {
        delete :destroy,:menu_id => @menu.id,:id => menu_item.id
      }.should change(SpudMenuItem,:count).by(-1)
    end
  end

  end
