module Spud
  module Cms
    include ActiveSupport::Configurable

    config_accessor :menus_enabled,:templates_enabled,:root_page_name,:default_page_parts,:yield_body_as_content_block

    self.root_page_name = "home"
    self.menus_enabled = true
    self.templates_enabled = false
    self.default_page_parts = ["Body"]
	self.yield_body_as_content_block = false    
  end
end