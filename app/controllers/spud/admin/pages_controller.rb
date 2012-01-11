class Spud::Admin::PagesController < Spud::Admin::ApplicationController
	layout 'spud/admin/cms/detail'
	add_breadcrumb "Pages", :spud_admin_pages_path
	before_filter :load_page,:only => [:edit,:update,:show,:destroy]
	
	def index
		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "Pages"
		@pages = SpudPage.where(:spud_page_id => nil).order(:page_order).includes(:spud_pages).paginate :page => params[:page]
	end

	def show
	end

	def new
		add_breadcrumb "New", :new_spud_admin_page_path

		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "New Page"
		@templates = SpudTemplate.all
		@page = SpudPage.new
		@page.spud_page_partials.new(:name => "Body")
		# @page.spud_page_partials.new(:name => "Sidebar")
	end

	def create
		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "New Page"
		@page = SpudPage.new(params[:spud_page])
		
		if @page.save
			flash[:notice] = "Page Saved successfully"
			redirect_to spud_admin_pages_url() and return
		else
			flash[:error] = "Error creating page"
			@error_object_name = "page"
			render :action => "new"
		end
	end

	def edit
		add_breadcrumb "#{@page.name}", :spud_admin_page_path
		add_breadcrumb "Edit", :edit_spud_admin_page_path
		@page_thumbnail = "spud/admin/pages_thumb.png"
		@page_name = "Edit Page"
		@templates = SpudTemplate.all
		if @page.spud_page_partials.blank?
			@page.spud_page_partials.new(:name => "Body")
		end
	end

	def update
		if @page.update_attributes(params[:spud_page])
			flash[:notice] = "Page updated successfully!"
			redirect_to spud_admin_pages_url() and return
		else
			flash[:error] = "There was an error saving this page"
			render :action => "edit"
		end

	end

	def destroy
		status = 500
		if @page.destroy
			flash[:notice] = "Page removed successfully!"
			status = 200
		else
			flash[:error] = "Error removing page"
		end
		respond_to do |format|
			format.js {render :status => status}
			format.html { redirect_to spud_admin_pages_url()}
		end
	end

private
	def load_page
		@page = SpudPage.where(:id => params[:id]).includes(:spud_custom_fields,:spud_page_partials).first
		if @page.blank?
			flash[:error] = "Page not found!"
			redirect_to spud_admin_pages_url() and return false
		end
		return true
	end
end
