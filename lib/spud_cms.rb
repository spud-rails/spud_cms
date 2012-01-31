module Spud
	module Cms
	   require 'spud_cms/configuration'
	   require 'spud_cms/engine' if defined?(Rails)
		require 'spud_cms/test_files' if ENV["RAILS_ENV"] == 'test'
    end
end
