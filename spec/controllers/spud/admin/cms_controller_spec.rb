require 'spec_helper'

describe Spud::Admin::CmsController do
  it "should return site_config by short_name" do
    Spud::Cms.configure do |config|
      config.multisite_config = [{:short_name => "siteb",:site_name => "Test Site B",:site_id => 2}]
    end

    Spud::Cms.site_config_for_short_name(:siteb)[:site_id].should == 2
  end
end
