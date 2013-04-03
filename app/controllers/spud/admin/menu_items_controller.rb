class Spud::Admin::MenuItemsController < Spud::Admin::CmsController
	add_breadcrumb "Menus", :spud_admin_menus_path
	belongs_to_spud_app :menus, :page_title => "Menu Items"
	layout 'spud/admin/detail'
	before_filter :load_menu
	before_filter :load_menu_item, :only => [:edit,:update,:show,:destroy,:reorder]


	def index
		@menu_items = @menu.spud_menu_items.order(:menu_order).includes(:spud_menu_items)
		respond_with @menu_items
	end

	def new
		add_breadcrumb "New", :new_spud_admin_page_path

		@menu_item = @menu.spud_menu_items.new
		respond_with @menu_item
	end

	def create

		add_breadcrumb "New", :new_spud_admin_page_path
		@menu_item = SpudMenuItem.new(menu_item_params)
		@menu_item.spud_menu_id = @menu.id
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
		flash[:notice] = "Menu Created successfully!" if @menu_item.save



		respond_with @menu_item,:location => spud_admin_menu_menu_items_url
	end

	def edit
		add_breadcrumb "Edit #{@menu_item.name}", :edit_spud_admin_menu_menu_item_path
		if @menu_item.parent_type == "SpudMenu"
			@menu_item.parent_id = nil
		end
		respond_with @menu_item
	end

	def update

		add_breadcrumb "Edit #{@menu_item.name}", :edit_spud_admin_menu_menu_item_path
		if params[:spud_menu_item][:parent_id].blank?
			params[:spud_menu_item][:parent_type] = "SpudMenu"
			params[:spud_menu_item][:parent_id] = @menu.id
		else
			params[:spud_menu_item][:parent_type] = "SpudMenuItem"
		end
		@menu_item.attributes = menu_item_params
		@menu_item.spud_menu_id = @menu.id
		flash[:notice] = "Menu saved successfully!" if @menu_item.save

		respond_with @menu_item,:location => spud_admin_menu_menu_items_url
	end

	def destroy

		flash[:notice] = "Menu Item removed!" if @menu_item.destroy

		respond_with @menu_item,:location => spud_admin_menu_menu_items_url
	end

	def reorder
		#id param
		#source position
		#destination position
		#parent
				# @menu_items = @menu.spud_menu_items.order(:menu_order).includes(:spud_menu_items).paginate :page => params[:page]


	end
private
	def load_menu

		@menu = SpudMenu.where(:id => params[:menu_id]).first

		if @menu.blank?
			flash[:error] = "Menu not found!"
			redirect_to spud_admin_menus_url() and return false
		elsif Spud::Core.multisite_mode_enabled && @menu.site_id != session[:admin_site]
			flash[:warning] = "Site Context Changed. The menu you were viewing is not associated with the current site. Redirected back to menu selections."
			redirect_to spud_admin_menus_url() and return false
		end
		add_breadcrumb "#{@menu.name}", :spud_admin_menu_menu_items_path
	end

	def load_menu_item
		@menu_item = SpudMenuItem.where(:id =>params[:id]).first
		if @menu_item.blank?
			flash[:error] = "Menu Item not found!"
			redirect_to spud_admin_menu_menu_items_url() and return false
		end
	end

	def menu_item_params
		params.require(:spud_menu_item).permit(:name,:parent_type,:parent_id,:item_type,:spud_page_id,:menu_order,:url,:classes)
	end

end
