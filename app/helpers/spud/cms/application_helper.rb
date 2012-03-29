module Spud::Cms::ApplicationHelper
	def sp_list_pages(options = {})
		
		pages = SpudPage.public.published_pages
		
		if Spud::Core.multisite_mode_enabled
			site_config = Spud::Core.site_config_for_host(request.host_with_port)
			pages = pages.site(site_config[:site_id]) if !site_config.blank?
		end
		start_page = nil
		max_depth = 0
		active_class = "menu-active"
		if !options.blank?
			if options.has_key?(:exclude)
				
				pages = pages.where(["name NOT IN (?)",options[:exclude]])
			end
			if options.has_key?(:start_page_id)
				start_page = options[:start_page_id]
			end
			if options.has_key?(:id)
				content = "<ul id='#{options[:id]}' #{"class='#{options[:class]}'" if options.has_key?(:class)}>"
			else
				content = "<ul #{"class='#{options[:class]}'" if options.has_key?(:class)}>"
			end
			if options.has_key?(:active_class)
				active_class = options[:acive_class]
			end
			if options.has_key?(:max_depth)
				max_depth = options[:max_depth]
			end
			
		else
			content = "<ul>"
		end

		pages = pages.all.group_by(&:spud_page_id)
		if pages[start_page].blank?
			
			return ""
		end
		pages[start_page].sort_by{|p| p.page_order}.each do |page|
			active = false
			if !page.url_name.blank?
				if current_page?(page_path(:id => page.url_name))
					active = true
				elsif page.url_name == Spud::Cms.root_page_name && current_page?(root_path)
					active = true
				end
			end
			content += "<li class='#{active_class if active}'><a href='#{page_path(:id => page.url_name)}'>#{page.name}</a>"
			if max_depth == 0 || max_depth > 1
				content += sp_list_page(page,pages,2,max_depth,options)
			end
			content += "</li>"
		end
		content += "</ul>"
		
		return content.html_safe
	end


	def sp_list_menu(options = {})

		max_depth = 0
		menu = SpudMenu
		if Spud::Core.multisite_mode_enabled
			site_config = Spud::Core.site_config_for_host(request.host_with_port)
			menu = menu.site(site_config[:site_id]) if !site_config.blank?
		end
		if !options.blank?

			if options.has_key?(:menu_id)
				menu = menu.where(:id => options[:menu_id])
			end
			if  options.has_key?(:name)
				menu = menu.where(:name => options[:name])
			end
			if options.has_key?(:id)
				content = "<ul id='#{options[:id]}' #{"class='#{options[:class]}'" if options.has_key?(:class)}>"
			else
				content = "<ul #{"class='#{options[:class]}'" if options.has_key?(:class)}>"
			end
			

			if options.has_key?(:max_depth)
				max_depth = options[:max_depth]
			end
		else
			content = "<ul>"
		end
		menu = menu.first
		if menu.blank?
			
			return ""
		end
		menu_items = menu.spud_menu_items_combined.select("
			#{SpudMenuItem.table_name}.id as id,
			#{SpudMenuItem.table_name}.url as url,
			#{SpudMenuItem.table_name}.classes as classes,
			#{SpudMenuItem.table_name}.parent_type as parent_type,
			#{SpudMenuItem.table_name}.menu_order as menu_order,
			#{SpudMenuItem.table_name}.parent_id as parent_id,
			#{SpudMenuItem.table_name}.name as name,
			#{SpudPage.table_name}.url_name as url_name").order(:parent_type,:parent_id).joins("LEFT JOIN #{SpudPage.table_name} ON (#{SpudPage.table_name}.id = #{SpudMenuItem.table_name}.spud_page_id)").all

		grouped_items = menu_items.group_by(&:parent_type)
		if grouped_items["SpudMenu"].blank?
			
			return ""
		end
		child_items = grouped_items["SpudMenuItem"].blank? ? [] : grouped_items["SpudMenuItem"].group_by(&:parent_id)
		

		grouped_items["SpudMenu"].sort_by{|p| p.menu_order}.each do |item|
			active = false
			if !item.url_name.blank?
				if current_page?(page_path(:id => item.url_name))
					active = true
				elsif item.url_name == Spud::Cms.root_page_name && current_page?(root_path)
					active = true
				end
			elsif current_page?(item.url)
				active = true
			end
			content += "<li class='#{"menu-active" if active} #{item.classes if !item.classes.blank?}'><a class='#{"menu-active" if active} #{item.classes if !item.classes.blank?}' href='#{!item.url_name.blank? ? (item.url_name == Spud::Cms.root_page_name ? root_path() : page_path(:id => item.url_name))  : item.url}'>#{item.name}</a>"
			if max_depth == 0 || max_depth > 1
				content += sp_list_menu_item(child_items,item.id,2,max_depth)
			end
			content += "</li>"
		end
		
		content += "</ul>"
		
		return content.html_safe
	end

	def sp_menu_with_seperator(options={})
		
		seperator = "&nbsp;|&nbsp;".html_safe
		if(options.has_key?(:seperator))
			seperator = options[:seperator]
		end

		menu = SpudMenu.where(:name => options[:name])
		if Spud::Core.multisite_mode_enabled
			site_config = Spud::Core.site_config_for_host(request.host_with_port)
			menu = menu.site(site_config[:site_id]) if !site_config.blank?
		end
		menu = menu.first
		menu_items = menu.spud_menu_items_combined.select("
			#{SpudMenuItem.table_name}.id as id,
			#{SpudMenuItem.table_name}.url as url,
			#{SpudMenuItem.table_name}.classes as classes,
			#{SpudMenuItem.table_name}.parent_type as parent_type,
			#{SpudMenuItem.table_name}.menu_order as menu_order,
			#{SpudMenuItem.table_name}.parent_id as parent_id,
			#{SpudMenuItem.table_name}.name as name,
			#{SpudPage.table_name}.url_name as url_name").order(:parent_type,:parent_id).joins("LEFT JOIN #{SpudPage.table_name} ON (#{SpudPage.table_name}.id = #{SpudMenuItem.table_name}.spud_page_id)").all
		
		menu_tags = []		
		menu_items.sort_by{|p| p.menu_order}.each do |item|
			menu_tags += ["<a #{"class='#{item.classes}' " if !item.classes.blank?}href='#{!item.url_name.blank? ? (item.url_name == Spud::Cms.root_page_name ? root_path() : page_path(:id => item.url_name)) : item.url}'>#{item.name}</a>"]
		end
		
		return menu_tags.join(seperator).html_safe
	end
private
	def sp_list_menu_item(items,item_id,depth,max_depth)

		spud_menu_items = items[item_id]
		if spud_menu_items == nil
			return ""
		end
		content = "<ul>"
		
		spud_menu_items.sort_by{|p| p.menu_order}.each do |item|
			active = false
			if !item.url_name.blank?
				if current_page?(page_path(:id => item.url_name))
					active = true
				elsif item.url_name == Spud::Cms.root_page_name && current_page?(root_path)
					active = true
				end
			elsif current_page?(item.url)
				active = true
			end
			content += "<li class='#{"menu-active" if active} #{item.classes if !item.classes.blank?}'><a class='#{"menu-active" if active} #{item.classes if !item.classes.blank?}' href='#{!item.url_name.blank? ? (item.url_name == Spud::Cms.root_page_name ? root_path() : page_path(:id => item.url_name)) : item.url}'>#{item.name}</a>"
			if max_depth == 0 || max_depth > depth
				content += sp_list_menu_item(items,item.id,depth+1,max_depth)
			end
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
	def sp_list_page(page,collection,depth,max_depth,options = {})
		active_class = 'menu-active'
		if options.has_key?(:active_class)
			active_class = options[:active_class]
		end
		if collection[page.id].blank?
			return ""
		end
		content = "<ul>"
		collection[page.id].sort_by{|p| p.page_order}.each do |page|
			active = false
			if !page.url_name.blank?
				if current_page?(page_path(:id => page.url_name))
					active = true
				elsif page.url_name == Spud::Cms.root_page_name && current_page?(root_path)
					active = true
				end
			end

			content += "<li class='#{active_class if active}'><a href='#{page_path(:id => page.url_name)}'>#{page.name}</a>"
			if max_depth == 0 || max_depth > depth
				content += sp_list_page(page,collection,depth+1,max_depth,options)
			end
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
	

	
	
end
