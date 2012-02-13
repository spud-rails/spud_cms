module Spud::Cms::ApplicationHelper
	def sp_list_pages(options = {})
		pages = SpudPage.public.published_pages
		start_page = nil
		if !options.blank?
			if options.has_key?(:exclude)
				
				pages = pages.where(["name NOT IN (?)",options[:exclude]])
			end
			if options.has_key?(:start_page_id)
				start_page = options[:start_page_id]
			end
			if options.has_key?(:id)
				content = "<ul id='#{options[:id]}'>"
			else
				content = "<ul>"
			end
		else
			content = "<ul>"
		end

		pages = pages.all.group_by(&:spud_page_id)
		if pages[start_page].blank?
			return ""
		end
		pages[start_page].sort_by{|p| p.page_order}.each do |page|
			content += "<li><a href='#{page_path(:id => page.url_name)}'>#{page.name}</a>"
			content += sp_list_page(page,pages)
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end


	def sp_list_menu(options = {})
		max_depth = 0
		menu = SpudMenu
		if !options.blank?
			if options.has_key?(:menu_id)
				menu = menu.where(:id => options[:menu_id])
			end
			if  options.has_key?(:name)
				menu = menu.where(:name => options[:name])
			end
			if options.has_key?(:id)
				content = "<ul id='#{options[:id]}'>"
			else
				content = "<ul>"
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
		menu_items = menu.spud_menu_items_combined.select("spud_menu_items.id as id,spud_menu_items.url as url,spud_menu_items.classes as classes,spud_menu_items.parent_type as parent_type,spud_menu_items.menu_order as menu_order,spud_menu_items.parent_id as parent_id,spud_menu_items.name as name,spud_pages.url_name as url_name").order(:parent_type,:parent_id).joins("LEFT JOIN spud_pages ON (spud_pages.id = spud_menu_items.spud_page_id)").all

		grouped_items = menu_items.group_by(&:parent_type)
		if grouped_items["SpudMenu"].blank?
			return ""
		end
		child_items = grouped_items["SpudMenuItem"].blank? ? [] : grouped_items["SpudMenuItem"].group_by(&:parent_id)
		

		grouped_items["SpudMenu"].sort_by{|p| p.menu_order}.each do |item|
			content += "<li><a #{"class='#{item.classes}' " if !item.classes.blank?}href='#{!item.url_name.blank? ? page_path(:id => item.url_name) : item.url}'>#{item.name}</a>"
			if max_depth == 0 || max_depth > 1
				content += sp_list_menu_item(child_items,item.id,2,max_depth)
			end
			content += "</li>"
		end
		# menu.spud_menu_items.order(:menu_order).each do |item|
		# 	content += "<li><a href='#{item.spud_page_id ? page_path(:id => item.spud_page.url_name) : item.url}'>#{item.name}</a>"
		# 	content += sp_list_menu_item(item)
		# 	content += "</li>"
		# end
		content += "</ul>"
		return content.html_safe
	end
private
	def sp_list_menu_item(items,item_id,depth,max_depth)

		spud_menu_items = items[item_id]
		if spud_menu_items == nil
			return ""
		end
		content = "<ul>"
		
		spud_menu_items.sort_by{|p| p.menu_order}.each do |item|
			content += "<li><a #{"class='#{item.classes}' " if !item.classes.blank?}href='#{!item.url_name.blank? ? page_path(:id => item.url_name) : item.url}'>#{item.name}</a>"
			if max_depth == 0 || max_depth > depth
				content += sp_list_menu_item(items,item.id,depth+1,max_depth)
			end
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
	def sp_list_page(page,collection)
		if collection[page.id].blank?
			return ""
		end
		content = "<ul>"
		collection[page.id].sort_by{|p| p.page_order}.each do |page|
			content += "<li><a href='#{page_path(:id => page.url_name)}'>#{page.name}</a>"
			content += sp_list_page(page,collection)
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
end
