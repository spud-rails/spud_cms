class Spud::Admin::MenusController < Spud::Admin::CmsController
	layout 'spud/admin/detail'
	belongs_to_spud_app :menus
	add_breadcrumb "Menus", {:action => :index}
	add_breadcrumb "New", '', :only => [:new,:create]
	add_breadcrumb "Edit", '', :only => [:edit,:update]
	before_filter :load_menu,:only => [:edit,:update,:show,:destroy]

	def index
		@menus = SpudMenu.site(session[:admin_site]).order(:name).paginate :page => params[:page]
		respond_with @menus
	end


	def new
		@menu = SpudMenu.new
		respond_with @menu
	end

	def create
		@menu = SpudMenu.new(params[:spud_menu])
		@menu.site_id = session[:admin_site]
		flash[:notice] = "New menu created" if @menu.save
		respond_with @menu,:location => @menu.id != nil ? spud_core.admin_menu_menu_items_url(:menu_id => @menu.id) : spud_core.admin_menus_url
	end

	def edit
		respond_with @menu
	end

	def update
		flash[:notice] = "Menu saved successfully" if @menu.update_attributes(params[:spud_menu])
		respond_with @menu,:location => spud_core.admin_menu_menu_items_url(:menu_id => @menu.id)
	end

	def destroy
		flash[:notice] = "Menu removed!" if @menu.destroy
		respond_with @menu,:location => spud_core.admin_menus_url
	end

private
	def load_menu
		@menu = SpudMenu.where(:id => params[:id]).first
		if @menu.blank?
			flash[:error] = "Menu not found!"
			redirect_to spud_core.admin_menus_url() and return false
		elsif Spud::Core.multisite_mode_enabled && @menu.site_id != session[:admin_site]
			flash[:warning] = "Site Context Changed. The menu you were viewing is not associated with the current site. Redirected back to menu selections."
			redirect_to spud_core.admin_menus_url() and return false
		end
	end
end
