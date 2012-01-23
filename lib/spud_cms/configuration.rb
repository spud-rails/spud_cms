module Spud
  module Cms
    include ActiveSupport::Configurable

    config_accessor :menus_enabled,:templates_enabled,:root_page_name,:default_page_parts

    self.root_page_name = "home"
    self.menus_enabled = true
    self.templates_enabled = false
    self.default_page_parts = ["Body"]
    
  end
end