class PageSweeper < ActionController::Caching::Sweeper
  observe :spud_page,:spud_menu_item
  # include Spud::Core::Engine.routes.url_helpers

  def before_save(record)
    if record.is_a?(SpudPage) && record.url_name_was != record.url_name
      if Spud::Cms.cache_mode == :full_page
        expire_page cache_path_for_page(record.url_name_was)
      elsif Spud::Cms.cache_mode == :action
        expire_action cache_path_for_page(record.url_name_was)
      end
    end
  end

  def after_save(record)
    expire_cache_for(record)
    expire_page spud_core.cms_sitemap_path(:format => :xml)
    expire_page spud_core.sitemap_path(:format => :xml)
  end

  def after_destroy(record)
    expire_cache_for(record)
    expire_page spud_core.cms_sitemap_path
    expire_page spud_core.sitemap_path
  end

private
  def expire_cache_for(record)
    if record.is_a?(SpudPage)
      if Spud::Cms.cache_mode == :full_page
        expire_page cache_path_for_page(record.url_name)
      elsif Spud::Cms.cache_mode == :action
        expire_action cache_path_for_page(record.url_name)
      end
    else
      Rails.cache.clear
      SpudPage.site(session[:admin_site]).published_pages.all.each {|page| expire_cache_for(page)}
    end
  end

  def cache_path_for_page(url_name)
    if url_name == Spud::Cms.root_page_name
      spud_cms.root_path
    else
      spud_cms.page_path(:id => url_name)
    end
  end

end
