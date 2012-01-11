class PagesController < ApplicationController
	def show
		@page = SpudPage.where(:url_name => params[:id]).includes([:spud_template,:spud_page_partials,:spud_custom_fields]).first
		if @page.blank?
			flash[:error] = "Page not found"
			redirect_to root_url() and return
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
