
module Spud
	module Cms
	   require 'spud_cms/configuration'
     require 'spud_cms/template_parser'
     require 'spud_cms/liquid_snippet'
	   require 'spud_cms/engine' if defined?(Rails)
    end
end

