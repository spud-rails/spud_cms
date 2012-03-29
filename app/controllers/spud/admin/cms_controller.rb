class Spud::Admin::CmsController < Spud::Admin::ApplicationController
	around_filter :scope_multisite
	
private

	def scope_multisite
		if !Spud::Core.multisite_mode_enabled || session[:admin_site].blank?
			yield and return
		end
		site_config = Spud::Core.multisite_config.select{|p| p[:short_name].to_s == session[:admin_site].to_s}
		if !site_config.blank?
			site_config = site_config[0]
			SpudPage.set_table_name "#{site_config[:short_name]}_#{SpudPage.table_name}"
			SpudPagePartial.set_table_name "#{site_config[:short_name]}_#{SpudPagePartial.table_name}"
			SpudMenu.set_table_name "#{site_config[:short_name]}_#{SpudMenu.table_name}"
			SpudMenuItem.set_table_name "#{site_config[:short_name]}_#{SpudMenuItem.table_name}"
			SpudTemplate.set_table_name "#{site_config[:short_name]}_#{SpudTemplate.table_name}"
		end
		yield
	ensure
		SpudPage.set_table_name "spud_pages"
		SpudPagePartial.set_table_name "spud_page_partials"
		SpudMenu.set_table_name "spud_menus"
		SpudMenuItem.set_table_name "spud_menu_items"
		SpudTemplate.set_table_name "spud_templates"
	end
end
