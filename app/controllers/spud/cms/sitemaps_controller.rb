class Spud::Cms::SitemapsController < Spud::ApplicationController
	respond_to :xml
	# caches_page :show,:expires_in => 1.day
	def show
		@pages = SpudPage.published_pages.public.order(:spud_page_id)
		if Spud::Core.multisite_mode_enabled
			site_config = Spud::Core.site_config_for_host(request.host_with_port)
			@pages = @pages.site(!site_config.blank? ? site_config[:site_id] : 0)
		end
		@pages = @pages.all
		respond_with @pages
	end
end
