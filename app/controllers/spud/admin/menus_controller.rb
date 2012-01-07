class Spud::Admin::MenusController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	add_breadcrumb "Menus", :spud_admin_menus_path
	before_filter :load_menu,:only => [:edit,:update,:show,:destroy]
	
	def index
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Menus"
		@menus = SpudMenu.order(:name).paginate :page => params[:page]
	end

	

	def new
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Menus"
		add_breadcrumb "New", :new_spud_admin_menu_path
		@menu = SpudMenu.new
	end

	def create
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Menus"
		add_breadcrumb "New", :new_spud_admin_menu_path
		@menu = SpudMenu.new(params[:spud_menu])
		if @menu.save
			flash[:notice] = "New menu created"
			redirect_to spud_admin_menu_menu_items_url(:menu_id => @menu.id)
		else
			flash[:error] = "Error saving menu"
			@error_object_name = "menu"
			render :action => "new"
		end
	end

	def edit
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Edit #{@menu.name}"
		add_breadcrumb "#{@menu.name}", :spud_admin_menu_menu_items_path
		add_breadcrumb "Edit", :edit_spud_admin_menu_path
	end

	def update
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Edit #{@menu.name}"
		add_breadcrumb "#{@menu.name}", :spud_admin_menu_menu_items_path
		add_breadcrumb "Edit", :edit_spud_admin_menu_path
		if @menu.update_attributes(params[:spud_menu])
			flash[:notice] = "Menu saved successfully"
			redirect_to spud_admin_menu_menu_items_url(:menu_id => @menu.id)

		else
			flash[:error] = "Error updating menu"
			@error_object_name = "menu"
			render :action => "edit"
		end
	end

	def destroy
		status = 500
		if @menu.destroy
			status = 200
		end

		respond_to do |format|
			format.js {
				render :status => status
			}
			format.html {
				flash[:error] = "Error removing menu" if status == 500
				flash[:notice] = "Menu saved successfully" if status == 200
				redirect_to spud_admin_menus_url()
			}
		end
	end

private
	def load_menu
		@menu = SpudMenu.where(:id => params[:id]).first
		if @menu.blank?
			flash[:error] = "Menu not found!"
			redirect_to spud_admin_menus_url() and return false
		end
	end
end
