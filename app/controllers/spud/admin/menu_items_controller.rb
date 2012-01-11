class Spud::Admin::MenuItemsController < Spud::Admin::ApplicationController
	add_breadcrumb "Menus", :spud_admin_menus_path
	layout 'spud/admin/detail'
	before_filter :load_menu
	before_filter :load_menu_item, :only => [:edit,:update,:show,:destroy]

	def index
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Menus"
		@menu_items = @menu.spud_menu_items.order(:menu_order).includes(:spud_menu_items).paginate :page => params[:page]
	end

	def new
		add_breadcrumb "New", :new_spud_admin_page_path

		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "New Menu Item"
		
		@menu_item = @menu.spud_menu_items.new
	end

	def create
		add_breadcrumb "New", :new_spud_admin_page_path
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "New Menu Item"
		@menu_item = SpudMenuItem.new(params[:spud_menu_item])
		if params[:spud_menu_item][:parent_id].blank?
			@menu_item.parent_id = @menu.id
			@menu_item.parent_type = "SpudMenu"
		else
			@menu_item.parent_type = "SpudMenuItem"
		end
		if @menu_item.name.blank? && !@menu_item.spud_page.blank?
			@menu_item.name = @menu_item.spud_page.name
		end
		if @menu_item.menu_order.blank?
			highest_sibling = @menu_item.parent.spud_menu_items.order("menu_order desc").first
			if !highest_sibling.blank?
				@menu_item.menu_order = highest_sibling.menu_order + 1
			end
		end
		if @menu_item.save
			flash[:notice] = "Menu Created successfully!"
			redirect_to spud_admin_menu_menu_items_url() and return
		else
			flash[:error] = "Error saving menu item"
			@error_object_name = "menu_item"
			render :action => "new"
		end
	end

	def edit
		add_breadcrumb "Edit #{@menu_item.name}", :edit_spud_admin_menu_menu_item_path
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Edit #{@menu_item.name}"
		if @menu_item.parent_type == "SpudMenu"
			@menu_item.parent_id = nil
		end
	end

	def update
		add_breadcrumb "Edit #{@menu_item.name}", :edit_spud_admin_menu_menu_item_path
		@page_thumbnail = "spud/admin/menus_thumb.png"
		@page_name = "Edit #{@menu_item.name}"
		if params[:spud_menu_item][:parent_id].blank?
			params[:spud_menu_item][:parent_type] = "SpudMenu"
			params[:spud_menu_item][:parent_id] = @menu.id
		else
			params[:spud_menu_item][:parent_type] = "SpudMenuItem"
		end
		if @menu_item.update_attributes(params[:spud_menu_item])
			flash[:notice] = "Menu saved successfully!"
			redirect_to spud_admin_menu_menu_items_url() and return

		else
			flash[:error] = "Error saving menu item"
			render :action => "edit"
		end
	end

	def destroy
		status = 500
		if @menu_item.destroy
			status = 200
		end
		respond_to do |format|
			format.js { render :status => status}
			format.html {
				flash[:notice] = "Menu Item removed!" if status == 200
				flash[:error] = "Error removing menu item!" if status == 500
				redirect_to spud_admin_menu_menu_items_path() and return
			}
		end
	end
private
	def load_menu

		@menu = SpudMenu.where(:id => params[:menu_id]).first
		if @menu.blank?
			flash[:error] = "Menu not found!"
			redirect_to spud_admin_menus_url() and return false
		end
		add_breadcrumb "#{@menu.name}", :spud_admin_menu_menu_items_path
	end

	def load_menu_item
		@menu_item = SpudMenuItem.where(:id => params[:id]).first
		if @menu_item.blank?
			flash[:error] = "Menu Item not found!"
			redirect_to spud_admin_menu_menu_items_url() and return false
		end
	end

end
