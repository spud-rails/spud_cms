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

  end
