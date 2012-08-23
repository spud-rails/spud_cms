class PagesController < ApplicationController
	caches_action :show, :if => Proc.new { |c| Spud::Cms.enable_action_caching }

	respond_to :html

	# caches_page :show, :if => Proc.new { |c| Spud::Cms.enable_full_page_caching }
	after_filter({:only => [:show]}) do |c|
		return if !Spud::Cms.enable_full_page_caching
		if @page && @page.is_private? == false
	    c.cache_page(nil, nil, false)
		end
  end

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

		@page = SpudPage.published_pages.where(:url_name => url_name).includes([:spud_template,:spud_page_partials])

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

			# flash[:error] = "Page not found"
			# if !params[:id].blank?
			# 	redirect_to root_url() and return
			# else
			# 	return
			# end
			render_404
			return
		end

		if @page.is_private?
			if defined?(require_user) && require_user == false
				logger.debug("responds to require user!")
				return
			end
			logger.debug("does not!")
		end

		layout = Spud::Cms.default_page_layout

		# MultiSite Code Block
		if Spud::Core.multisite_mode_enabled && !site_config.blank?
			cms_config = Spud::Cms.site_config_for_short_name(site_config[:short_name])
			layout = cms_config[:default_page_layout] if !cms_config.blank? && !cms_config[:default_page_layout].blank?
		end

		if !@page.spud_template.blank?
			if !@page.spud_template.base_layout.blank?
				layout = @page.spud_template.base_layout
			end
			@inline = @page.spud_template.content
		end

		render :layout => layout

	end

private

	def render_404
		Spud::Cms.template_404 ? render(Spud::Cms.template_404,:status => 404) : render(:text=>nil,:status => 404)
 	end

end
