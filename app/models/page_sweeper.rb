class PageSweeper < ActionController::Caching::Sweeper
  observe SpudPage,SpudTemplate,SpudMenuItem

  def after_save(record)
    logger.debug("SWEEPING!")
    expire_cache_for(record)
  end
  def after_destroy(record)
  	expire_cache_for(record)
  end
private
  def expire_cache_for(record)
  	if(record.is_a?(SpudTemplate))
  		record.spud_pages.each do |page|
  			expire_cache_for(page)
  		end
    elsif record.is_a?(SpudPage)
    	if Spud::Cms.enable_full_page_caching
    		if record.url_name == Spud::Cms.root_page_name
	        	expire_page root_path
		    else
  				expire_page page_path(:id => record.url_name)
			end
    	elsif Spud::Cms.enable_action_caching
    		if record.url_name == Spud::Cms.root_page_name
	        	expire_action root_path
		    else
				expire_action page_path(:id => record.url_name)
			end
    	end
    else
    	Rails.cache.clear
    	SpudPage.published_pages.all.each {|page| expire_cache_for(page)}
    end
  end
end