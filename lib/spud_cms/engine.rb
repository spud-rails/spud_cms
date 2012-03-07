require 'spud_core'
require 'spud_permalinks'
require 'codemirror-rails'
module Spud
  module Cms
    class Engine < Rails::Engine
     engine_name :spud_cms
     # config.autoload_paths << File.expand_path("../app/sweepers", __FILE__)
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
     
     initializer :admin do
      Spud::Core.configure do |config|
          config.admin_applications += [{:name => "Pages",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/pages",:order => 0}]
          if Spud::Cms.menus_enabled
            config.admin_applications += [{:name => "Menus",:thumbnail => "spud/admin/menus_thumb.png",:url => "/spud/admin/menus",:order => 2}]
          end
          if Spud::Cms.templates_enabled
            config.admin_applications += [{:name => "Templates",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/templates",:order => 4}]
          end
          if Spud::Cms.enable_sitemap == true
            config.sitemap_urls += [:spud_cms_sitemap_url]
          end
          
      end
     end
     initializer :spud_cms_routes do |config|
      config.routes_reloader.paths << File.expand_path('../page_route.rb', __FILE__)
     end
     initializer :load_priority, :after => :load_environment_config do |config|
      puts "Loading Railties Order"
      # Rails.application.config.railties_order = [:main_app, :all,Spud::Core::Engine,Spud::Cms::Engine]
     end
     initializer :assets do |config| 
    	Rails.application.config.assets.precompile += ["spud/admin/cms*"]
  	 end

  end 
 end
end
