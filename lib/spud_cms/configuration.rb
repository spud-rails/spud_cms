module Spud
  module Cms
    include ActiveSupport::Configurable

    config_accessor :menus_enabled,:templates_enabled,:root_page_name,:default_page_parts,:yield_body_as_content_block,:default_page_layout,:enable_sitemap,:enable_full_page_caching,:enable_action_caching

    self.root_page_name = "home"
    self.menus_enabled = true
    self.templates_enabled = false
    self.default_page_layout = 'application'
    self.default_page_parts = ["Body"]
  	self.yield_body_as_content_block = false    
    self.enable_full_page_caching = false
    self.enable_action_caching = false
    self.enable_sitemap = true
  end
end