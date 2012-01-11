require 'spud_cms'
require 'rails'
require 'action_controller'
require 'spud_admin'
require 'paperclip'

module SpudCms
 class Engine < Rails::Engine
     engine_name :spud_cms
     initializer :assets do |config| 
    	Rails.application.config.assets.precompile += [ 
    	   "jquery.wymeditor.pack.js",
           "wymeditor/*", 
           "wymeditor/lang/*", 
           "wymeditor/skins/default/*", 
           "wymeditor/skins/default/**/*",
        ]
  	end 
     
 end
end
