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
		
		pages.each do |page|
			content += "<li><a href='#{page_path(:url_name => page.url_name)}'>#{page.name}</a>"
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
				content = "<ul id='#{options.id}'>"
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

		menu.spud_menu_items.each do |item|
			content += "<li><a href='#{item.spud_page_id ? page_path(:url_name => item.spud_page.url_name) : item.url}'>#{item.name}</a>"
			content += sp_list_menu_item(item)
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
private
	def sp_list_menu_item(item)
		if item.spud_menu_items.count == 0
			return ""
		end
		content = "<ul>"
		item.spud_menu_items.each do |item|
			content += "<li><a href='#{item.spud_page_id ? page_path(:url_name => item.spud_page.url_name) : item.url}'>#{item.name}</a>"
			content += sp_list_menu_item(item)
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
		page.spud_pages.each do |page|
			content += "<li><a href='#{page_path(:url_name => page.url_name)}'>#{page.name}</a>"
			content += sp_list_page(page)
			content += "</li>"
		end
		content += "</ul>"
		return content.html_safe
	end
end
