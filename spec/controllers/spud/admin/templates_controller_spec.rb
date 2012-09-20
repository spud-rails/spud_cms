require 'spec_helper'

describe Spud::Admin::TemplatesController do
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
    session[:admin_site] = nil
  end


  describe :index do
    it "should return an array of templates" do
      2.times {|x|  s = FactoryGirl.create(:spud_template)}
      get :index

      assigns(:templates).count.should be > 1
    end

  end

  describe :new do
    it "should response with new template" do
      get :new
      assigns(:template).should_not be_blank
      response.should be_success
    end
  end
  describe :create do
    it "should create a new template with a valid form submission" do
      lambda {
        post :create, :spud_template => FactoryGirl.attributes_for(:spud_template).reject{|k,v| k.to_sym == :site_id}
      }.should change(SpudTemplate,:count).by(1)
      response.should be_redirect
    end

    it "should not create a template with an invalid form entry" do
      lambda {
        post :create, :spud_template => FactoryGirl.attributes_for(:spud_template,:name => nil).reject{|k,v| k.to_sym == :site_id}
      }.should_not change(SpudTemplate,:count)
    end

  end


  describe :edit do
    it "should response with template by id" do
      t1 = FactoryGirl.create(:spud_template)
      t2 = FactoryGirl.create(:spud_template)
      get :edit,:id => t2.id
      assigns(:template).should == t2
    end
    it "should redirect to index if template not found" do
      get :edit,:id => 3
      response.should redirect_to spud_admin_templates_url
    end
  end

  describe :update do
   it "should update the name when the name attribute is changed" do
      template = FactoryGirl.create(:spud_template)
      new_name = 'MyTemplate'
      lambda {
        put :update,:id => template.id, :spud_template => template.attributes.merge!(:name => new_name).reject{|k,v| k.to_sym == :site_id}
        template.reload
      }.should change(template,:name).to(new_name)

    end

  end

  describe :destroy do
    it "should destroy the template" do
      template = FactoryGirl.create(:spud_template)
      lambda {
        delete :destroy,:id => template.id
      }.should change(SpudTemplate,:count).by(-1)
    end
  end


    describe :multisite do
    before(:each) do
      Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = true
        config.multisite_config = [{:hosts => ["test.host"], :site_name =>"Site B", :site_id => 1,:short_name => "siteb"}]
      end
      Spud::Cms.configure do |config|
        config.multisite_config = [{:short_name => "siteb",:default_page_parts => ["Body","Sidebar"]}]
      end
      session[:admin_site] = 1
    end
      describe :new do
        it "should prepopulate the page_parts field with the current config" do

          get :new
          assigns(:template).page_parts.should == 'Body,Sidebar'
          response.should be_success
        end
      end

      describe :edit do
        it "should not allow editing of a template that is different from the current admin site" do
          template = FactoryGirl.create(:spud_template)
          get :edit,:id => template.id
          response.should redirect_to spud_admin_templates_url
          flash[:warning].should_not be_blank
        end
      end

  end
end
