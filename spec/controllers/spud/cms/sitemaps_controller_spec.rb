require 'spec_helper'

describe Spud::Cms::SitemapsController do
  describe :show do
    it "should return the sitemap urls" do
      
      get :show, :format => :xml
      
      assigns(:pages).should == SpudPage.published_pages.public.order(:spud_page_id)
    end
    
    it "should only respond to an XML format" do
      get :show
      response.response_code.should == 406
    end
  end
end