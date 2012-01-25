require 'spud_admin'
require 'paperclip'
require 'codemirror-rails'
module Spud
  module Cms
    class Engine < Rails::Engine
     engine_name :spud_cms

     initializer :admin do
      Spud::Core.configure do |config|
          config.admin_applications += [{:name => "Pages",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/pages",:order => 0},
            {:name => "Media",:thumbnail => "spud/admin/media_thumb.png",:url => "/spud/admin/media",:order => 3}
            
          ]
          if Spud::Cms.menus_enabled
            config.admin_applications += [{:name => "Menus",:thumbnail => "spud/admin/menus_thumb.png",:url => "/spud/admin/menus",:order => 2}]
          end
          if Spud::Cms.templates_enabled
            config.admin_applications += [{:name => "Templates",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/templates",:order => 4}]
          end
      end
     end
     initializer :assets do |config| 
    	Rails.application.config.assets.precompile += ["spud/admin/cms*"]
  	 end

  end 
 end
end
