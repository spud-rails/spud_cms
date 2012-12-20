require 'spec_helper'

describe Spud::Cms::SitemapsController do
  describe :show do
    before(:each) do
        Spud::Core.configure do |config|
          config.site_name = "Test Site"
          config.multisite_mode_enabled = false
          config.multisite_config = []
        end

      end
    it "should return the sitemap urls" do

      get :show, :use_route => :spud_core, :format => :xml

      assigns(:pages).should == SpudPage.published_pages.public.order(:spud_page_id)
    end

    it "should only respond to an XML format" do
      get :show, :use_route => :spud_core
      response.response_code.should == 406
    end

    describe :multisite do
      before(:each) do
        Spud::Core.configure do |config|
          config.site_name = "Test Site"
          config.multisite_mode_enabled = true
          config.multisite_config = [{:hosts => ["test.host"], :site_name =>"Site B", :site_id => 1}]
        end
      end

      it "should only assign pages for current site" do
        2.times {|x|  s = FactoryGirl.create(:spud_page)}
        3.times {|x|  s = FactoryGirl.create(:spud_page,:site_id => 1)}

        get :show, :use_route => :spud_core, :format => :xml

        assigns(:pages).should == SpudPage.published_pages.public.order(:spud_page_id).site(1)

      end

    end
  end


end
