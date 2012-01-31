class Spud::Cms::SitemapsController < Spud::ApplicationController
	respond_to :xml
	caches_page :show,:expires_in => 1.day
	def show
		@pages = SpudPage.published_pages.public.order(:spud_page_id)
		respond_with @pages
	end
end
