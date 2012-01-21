class PagesController < ApplicationController
	def show
		url_name = !params[:id].blank? ? params[:id] : Spud::Cms.root_page_name
		@page = SpudPage.where(:url_name => url_name).includes([:spud_template,:spud_page_partials,:spud_custom_fields]).first
		if @page.blank?
			flash[:error] = "Page not found"
			if !params[:id].blank?
				redirect_to root_url() and return
			else
				return
			end
		end
		layout = 'application'

		if !@page.spud_template.blank?
			if !@page.spud_template.base_layout.blank?
				layout = @page.spud_template.base_layout
			end
			render :inline => @page.spud_template.content, :layout => layout
		else
			render :layout => layout
		end
		
	end
end
