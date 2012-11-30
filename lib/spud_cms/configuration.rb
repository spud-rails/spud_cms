module Spud
  module Cms
    include ActiveSupport::Configurable

    config_accessor :menus_enabled,:root_page_name,:yield_body_as_content_block,:default_page_layout,:enable_sitemap,:multisite_config,:max_revisions,:template_404, :cache_mode, :snippets_enabled, :automount
    self.automount = true
    self.menus_enabled = true
    self.snippets_enabled = true
    self.root_page_name = "home"
    self.default_page_layout = 'application'
  	self.yield_body_as_content_block = false
    self.cache_mode = nil #Options :full_page, :action

    self.enable_sitemap = true
    self.max_revisions = 10
    self.template_404 = nil
    self.multisite_config = []
    def self.site_config_for_short_name(short_name)
        configs = Spud::Cms.multisite_config.select{|p| p[:short_name].to_s == short_name.to_s}
        if configs.blank?
          return nil
        else
          return configs[0]
        end
    end

  end
end
