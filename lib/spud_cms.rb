
module Spud
	module Cms
	   require 'spud_cms/configuration'
	   require 'spud_cms/engine' if defined?(Rails)
    end
end

# if defined?(Rails)
# 	Rails.application.config.railties_order = [:main_app, :all,Spud::Cms::Engine]
# end
