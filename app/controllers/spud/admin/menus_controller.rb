class Spud::Admin::MenusController < Spud::Admin::CmsController
	layout 'spud/admin/detail'
	belongs_to_spud_app :menus
	add_breadcrumb "Menus", :spud_admin_menus_path
	before_filter :load_menu,:only => [:edit,:update,:show,:destroy]
	
	def index
		@menus = SpudMenu.site(session[:admin_site]).order(:name).paginate :page => params[:page]
		respond_with @menus
	end
	

	def new
		add_breadcrumb "New", :new_spud_admin_menu_path
		@menu = SpudMenu.new
		respond_with @menu
	end

	def create
		add_breadcrumb "New", :new_spud_admin_menu_path
		@menu = SpudMenu.new(params[:spud_menu])
		@menu.site_id = session[:admin_site]
		if @menu.save
			flash[:notice] = "New menu created" 
			respond_with @menu,:location => spud_admin_menu_menu_items_url(:menu_id => @menu.id)
		else
			respond_with @menu
		end
	end

	def edit
		add_breadcrumb "Edit #{@menu.name}", :edit_spud_admin_menu_path
		respond_with @menu
	end

	def update
		add_breadcrumb "Edit #{@menu.name}", :edit_spud_admin_menu_path
		
		flash[:notice] = "Menu saved successfully" if @menu.update_attributes(params[:spud_menu])
		respond_with @menu,:location => spud_admin_menu_menu_items_url(:menu_id => @menu.id)
	end

	def destroy
		flash[:notice] = "Menu removed!" if @menu.destroy
		respond_with @menu,:location => spud_admin_menus_url
	end

private
	def load_menu
		@menu = SpudMenu.site(session[:admin_site]).where(:id => params[:id]).first
		if @menu.blank?
			flash[:error] = "Menu not found!"
			redirect_to spud_admin_menus_url() and return false
		end
	end
end
