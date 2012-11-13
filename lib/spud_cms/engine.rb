require 'spud_core'
require 'spud_permalinks'
require 'codemirror-rails'
require 'liquid'

module Spud
  module Cms
    class Engine < Rails::Engine
      engine_name :spud_cms

      # config.active_record.observers = [] if config.active_record.observers.nil?
      # config.active_record.observers += [:page_observer]

      config.generators do |g|
        g.test_framework :rspec, :view_specs => false
      end

     initializer :admin do
      Spud::Core.configure do |config|
          config.admin_applications += [{:name => "Pages",:thumbnail => "spud/admin/pages_thumb.png",:url => "/spud/admin/pages",:order => 0}]
          if Spud::Cms.menus_enabled
            config.admin_applications += [{:name => "Menus",:thumbnail => "spud/admin/menus_thumb.png",:url => "/spud/admin/menus",:order => 2}]
          end

          if Spud::Cms.enable_sitemap == true
            config.sitemap_urls += [:spud_cms_sitemap_url]
          end

      end
     end
    initializer :model_overrides_cms do |config|
      ActiveRecord::Base.class_eval do
        include Spud::Searchable
      end
     end
    initializer :cms_sweepers do |config|
      Spud::Admin::ApplicationController.instance_eval do
        cache_sweeper :page_sweeper, :except => [:show,:index]
      end
    end

     initializer :spud_cms_routes do |config|
      config.routes_reloader.paths << File.expand_path('../page_route.rb', __FILE__)
     end

     initializer :assets do |config|
    	Rails.application.config.assets.precompile += ["spud/admin/cms*"]
  	 end

     initializer :template_parser do |config|
      @template_parser = Spud::Cms::TemplateParser.new()
     end

     def template_parser
      return @template_parser
     end

  end
 end
end
