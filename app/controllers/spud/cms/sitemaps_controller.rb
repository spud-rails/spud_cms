class Spud::Cms::SitemapsController < Spud::ApplicationController
	caches_page :show,:expires_in => 1.day
	def show
		@pages = SpudPage.published_pages.public.order(:spud_page_id)
	end
end
