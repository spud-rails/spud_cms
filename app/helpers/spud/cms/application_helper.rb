module Spud::Cms::ApplicationHelper
	def sp_list_pages(options = {})
		pages = SpudPage.parent_pages
		if !options.blank?
			if options.has_key?(:exclude)
				
				pages = pages.where(["name NOT IN (?)",options[:exclude]])
			end
			if options.has_key?(:id)
				content = "<ul id='#{options.id}'>"
			else
				content = "<ul>"
			end
		else
			content = "<ul>"
		end
		
		pages.order(:page_order).each do |page|
			content += "<li><a href='#{page_path(:id => page.url_name)}'>#{page.name}</a>"
			content += sp_list_page(page)
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end


	def sp_list_menu(options = {})
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
		else
			content = "<ul>"
		end
		menu = menu.first
		if menu.blank?
			return ""
		end
		menu_items = menu.spud_menu_items_combined.select("spud_menu_items.id as id,spud_menu_items.url as url,spud_menu_items.parent_type as parent_type,spud_menu_items.menu_order as menu_order,spud_menu_items.parent_id as parent_id,spud_menu_items.name as name,spud_pages.url_name as url_name").order(:parent_type,:parent_id).joins("LEFT JOIN spud_pages ON (spud_pages.id = spud_menu_items.spud_page_id)")
		# grouped_items = menu_items.group_by(&:parent_type,&:parent_id)
		menu_items.select{|item| item.parent_type == 'SpudMenu'}.sort_by{|p| p.menu_order}.each do |item|
			content += "<li><a href='#{!item.url_name.blank? ? page_path(:id => item.url_name) : item.url}'>#{item.name}</a>"
			content += sp_list_menu_item(menu_items,item.id)
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
	def sp_list_menu_item(items,item_id)
		spud_menu_items = items.select{|item| item.parent_type == 'SpudMenuItem' && item.parent_id == item_id}
		if spud_menu_items.count == 0
			return ""
		end
		content = "<ul>"
		spud_menu_items.sort_by{|p| p.menu_order}.each do |item|
			content += "<li><a href='#{!item.url_name.blank? ? page_path(:id => item.url_name) : item.url}'>#{item.name}</a>"
			content += sp_list_menu_item(items,item.id)
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
	def sp_list_page(page)
		if page.spud_pages.count == 0
			return ""
		end
		content = "<ul>"
		page.spud_pages.order(:page_order).each do |page|
			content += "<li><a href='#{page_path(:id => page.url_name)}'>#{page.name}</a>"
			content += sp_list_page(page)
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
end
