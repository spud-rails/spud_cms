class PagesController < ApplicationController
	caches_action :show, :if => Proc.new { |c| Spud::Cms.enable_full_page_caching }
	def show
		url_name = !params[:id].blank? ? params[:id] : Spud::Cms.root_page_name
		@page = SpudPage.published_pages.where(:url_name => url_name).includes([:spud_template,:spud_page_partials]).first
		if @page.blank?
			flash[:error] = "Page not found"
			if !params[:id].blank?
				redirect_to root_url() and return
			else
				return
			end
		end
		if @page.is_private?
			before_filter :require_user
		end
		layout = Spud::Cms.default_page_layout


		if !@page.spud_template.blank?
			if !@page.spud_template.base_layout.blank?
				layout = @page.spud_template.base_layout
			end
			@inline = @page.spud_template.content
			
		end
		render :layout => layout
		
	end
end
