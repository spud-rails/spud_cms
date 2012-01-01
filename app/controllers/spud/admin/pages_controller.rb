class Spud::Admin::PagesController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	add_breadcrumb "Pages", :spud_admin_pages_path
	def index
		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "Pages"
	end
end
