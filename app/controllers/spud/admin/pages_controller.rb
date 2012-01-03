class Spud::Admin::PagesController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	add_breadcrumb "Pages", :spud_admin_pages_path
	before_filter :load_user,:only => [:edit,:update,:show,:destroy]
	
	def index
		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "Pages"
	end

	def show
	end

	def new
		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "New Page"
		@templates = SpudTemplate.all
		@page = SpudPage.new
	end

	def create
		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "New Page"
	end

	def edit
	end

	def update
	end

	def destroy
	end

private
	def load_page
		@page = SpudPage.where(:id => params[:id]).first
		if @page.blank?
			flash[:error] = "Page not found!"
			redirect_to spud_admin_pages_url() and return false
		end
		return true
	end
end
