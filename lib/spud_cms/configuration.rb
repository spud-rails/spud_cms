module Spud
  module Cms
    include ActiveSupport::Configurable

    config_accessor :menus_enabled,:templates_enabled,:root_page_name

    self.root_page_name = "home"
    self.menus_enabled = true
    self.templates_enabled = false
    
  end
end