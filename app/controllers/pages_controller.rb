class PagesController < ApplicationController
	caches_action :show, :if => Proc.new { |c| Spud::Cms.enable_action_caching }
	# caches_page :show, :if => Proc.new { |c| Spud::Cms.enable_full_page_caching }
	after_filter({:only => [:show]}) do |c|
		return if !Spud::Cms.enable_full_page_caching
		if @page && @page.is_private? == false
		    c.cache_page(nil, nil, false)
		end
  	end
	def show
		url_name = !params[:id].blank? ? params[:id] : Spud::Cms.root_page_name
		@page = SpudPage.published_pages.where(:url_name => url_name).includes([:spud_template,:spud_page_partials]).first
		if @page.blank?
			@permalink = SpudPermalink.includes(:attachment).where(:url_name => url_name).first
			if !@permalink.blank? && @permalink.attachment_type == 'SpudPage'
				redirect_to @permalink.attachment.url_name == Spud::Cms.root_page_name ? root_url() : page_url(:id => @permalink.attachment.url_name) , :status => :moved_permanently and return
			end

			flash[:error] = "Page not found"
			if !params[:id].blank?
				redirect_to root_url() and return
			else
				return
			end
		end
		if @page.is_private?
			if self.respond_to?('require_user') && require_user == false
				return
			end
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
