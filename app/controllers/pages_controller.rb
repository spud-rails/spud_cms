class PagesController < ApplicationController
	respond_to :html

	before_filter :set_default_content_type

	# after_filter({:only => [:show]}) do |c|
	# 	if Spud::Cms.cache_mode == :full_page && @page && @page.is_private? == false
	#     c.cache_page(nil, nil, false)
	# 	end
 #  end

	def show
		# prevents 500 errors if a url like "/home.jpg" is hit
		if request.format != :html
			render_404
			return
		end

		url_name = !params[:id].blank? ? params[:id] : Spud::Cms.root_page_name

		# MultiSite Code Block
		if params[:id].blank? && Spud::Core.multisite_mode_enabled
			site_config = Spud::Core.site_config_for_host(request.host_with_port)
			if !site_config.blank?
				cms_config = Spud::Cms.site_config_for_short_name(site_config[:short_name])
				url_name = cms_config[:root_page_name] if !cms_config.blank? && !cms_config[:root_page_name].blank?
			end
		end

		@page = SpudPage.published_pages.where(:url_name => url_name).includes([:spud_page_partials])

		# MultiSite Code Block
		if Spud::Core.multisite_mode_enabled
			site_config = Spud::Core.site_config_for_host(request.host_with_port)
			@page = @page.site(!site_config.blank? ? site_config[:site_id] : nil)
		end

		@page = @page.first
		if @page.blank?
			@permalink = SpudPermalink.where(:url_name => url_name)

			# MultiSite Code Block
			if Spud::Core.multisite_mode_enabled
				@permalink = @permalink.site(!site_config.blank? ? site_config[:site_id] : nil)
			end
			@permalink = @permalink.first

			if !@permalink.blank? && @permalink.attachment_type == 'SpudPage'
				redirect_to @permalink.attachment.url_name == Spud::Cms.root_page_name ? root_url() : page_url(:id => @permalink.attachment.url_name) , :status => :moved_permanently and return
			end


			render_404
			return
		end

		if @page.is_private?
			return if defined?(require_user) && require_user == false
		end

		layout = Spud::Cms.default_page_layout

		# MultiSite Code Block
		if Spud::Core.multisite_mode_enabled && !site_config.blank?
			cms_config = Spud::Cms.site_config_for_short_name(site_config[:short_name])
			layout = cms_config[:default_page_layout] if !cms_config.blank? && !cms_config[:default_page_layout].blank?
		end

		layout = @page.layout || layout


		render :layout => layout

	end

private

	def render_404
	  raise ActionController::RoutingError.new('Not Found')
		# Spud::Cms.template_404 ? render(Spud::Cms.template_404,:status => 404, :formats => [:html]) : render(:text=>nil,:status => 404)
 	end

 	def set_default_content_type
 		if params[:format].blank?
			request.format = :html
		end
 	end

end
