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

  describe :new do
    it "should response with new snippet" do
      get :new, :use_route => :spud_core
      assigns(:snippet).should_not be_blank
      response.should be_success
    end
  end

  describe :create do
    it "should create a new snippet with a valid form submission" do
      lambda {
        post :create, :use_route => :spud_core, :spud_snippet => FactoryGirl.attributes_for(:spud_snippet).reject{|k,v| k == 'site_id' || k == 'id' || k == 'created_at' || k == 'updated_at'}
      }.should change(SpudSnippet,:count).by(1)
      response.should be_redirect
    end

    it "should not create a snippet with an invalid form entry" do
      lambda {
        post :create, :use_route => :spud_core, :spud_snippet => FactoryGirl.attributes_for(:spud_snippet,:name => nil).reject{|k,v| k == 'site_id' || k == 'id' || k == 'created_at' || k == 'updated_at'}
      }.should_not change(SpudSnippet,:count)
    end
  end

    describe :edit do
    it "should response with snippet by id" do
      snippet1 = FactoryGirl.create(:spud_snippet)
      snippet2 = FactoryGirl.create(:spud_snippet)
      get :edit, :use_route => :spud_core,:id => snippet2.id
      assigns(:snippet).should == snippet2
    end
    it "should redirect to index if snippet not found" do
      get :edit, :use_route => :spud_core,:id => 3
      response.should redirect_to spud_core.admin_snippets_url
    end

  end

  describe :update do
    it "should update the name when the name attribute is changed" do
      snippet = FactoryGirl.create(:spud_snippet)
      new_name = 'Awesome Snippet'
      lambda {
        put :update, :use_route => :spud_core,:id => snippet.id, :spud_snippet => snippet.attributes.merge!(:name => new_name).reject{|k,v| k == 'site_id' || k == 'id' || k == 'created_at' || k == 'updated_at'}
        snippet.reload
      }.should change(snippet,:name).to(new_name)

    end

    it "should redirect to the admin snippets after a successful update" do
      snippet = FactoryGirl.create(:spud_snippet)
      put :update, :use_route => :spud_core,:id => snippet.id,:spud_snippet => snippet.attributes.merge!(:name => "MyMenu").reject{|k,v| k == 'site_id' || k == 'id' || k == 'created_at' || k == 'updated_at'}

      response.should redirect_to(spud_core.admin_snippets_url)
    end
  end

  describe :destroy do
    it "should destroy the snippet" do
      snippet = FactoryGirl.create(:spud_snippet)
      lambda {
        delete :destroy, :use_route => :spud_core, :id => snippet.id
      }.should change(SpudSnippet,:count).by(-1)
      response.should be_redirect
    end

    it "should not destroy the snippet with a wrong id" do
      snippet = FactoryGirl.create(:spud_snippet)
      lambda {
        delete :destroy, :use_route => :spud_core,:id => "23532"
      }.should_not change(SpudSnippet,:count)
      response.should be_redirect
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
    it "should not allow editing of a snippet on a different site id" do
      snippet2 = FactoryGirl.create(:spud_snippet,:site_id => 1)
      get :edit, :use_route => :spud_core,:id => snippet2.id

      response.should redirect_to spud_core.admin_snippets_url
    end
  end
end
