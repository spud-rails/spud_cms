require 'spec_helper'

describe Spud::Admin::SnippetsController do
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

  end

  describe :index do
    it "should return an array of snippets" do
      2.times {|x|  s = FactoryGirl.create(:spud_snippet)}
      get :index, :use_route => :spud_core
      assigns(:snippets).count.should be > 1
    end
  end
end
