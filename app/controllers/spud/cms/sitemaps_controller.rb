class Spud::Cms::SitemapsController < Spud::ApplicationController
	respond_to :xml
	def show
		@pages = SpudPage.published_pages.is_public.order(:spud_page_id)
		if Spud::Core.multisite_mode_enabled
			site_config = Spud::Core.site_config_for_host(request.host_with_port)
			@pages = @pages.site(!site_config.blank? ? site_config[:site_id] : 0)
		end
		respond_with @pages
	end
end
