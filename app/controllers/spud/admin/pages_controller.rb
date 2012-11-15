class Spud::Admin::PagesController < Spud::Admin::CmsController
	layout 'spud/admin/cms/detail'
	add_breadcrumb "Pages", :spud_admin_pages_path
	belongs_to_spud_app :pages
	before_filter :load_page,:only => [:edit,:update,:show,:destroy]

	def index

		@pages = SpudPage.site(session[:admin_site]).where(:spud_page_id => nil).order(:page_order).includes(:spud_pages).paginate :page => params[:page]

    home_page = SpudPage.where(:url_name => Spud::Cms.root_page_name).first
    if home_page.blank?
      flash.now[:warning] = "You have not setup your default CMS page. This page will be your homepage. To do so, create a page with the name '#{Spud::Cms.root_page_name.titlecase}'"
    end

		respond_with @pages
	end

	def show
		layout = @page.layout || Spud::Cms.default_page_layout


		render :layout => layout
	end

	def new
		add_breadcrumb "New", :new_spud_admin_page_path

    layouts = Spud::Cms::Engine.template_parser.layouts(Spud::Core.site_config_for_id(session[:admin_site] || 0)[:short_name])
    layout, layout_info = layouts.select{|k,v| v[:default]}.flatten
		@page = SpudPage.new(:layout => layout)
		parts = layout_info[:partials]

		parts.each do |part|
			@page.spud_page_partials.new(:name => part.strip)
		end
		respond_with @page
	end

	def create

		@page = SpudPage.new(params[:spud_page])
		@page.site_id = session[:admin_site]
		if params[:preview] && params[:preview].to_i == 1
			preview
			return
		end
		flash[:notice] = "Page Saved successfully" if @page.save
		respond_with @page,:location => spud_admin_pages_url
	end

	def edit
		add_breadcrumb "#{@page.name}", :spud_admin_page_path
		add_breadcrumb "Edit", :edit_spud_admin_page_path

    layouts = Spud::Cms::Engine.template_parser.layouts(Spud::Core.site_config_for_id(session[:admin_site] || 0)[:short_name])
    layout, layout_info = layouts.select{|k,v| k == @page.layout}.flatten  if @page.layout.blank? == false
    if layout.blank?
      layout, layout_info = layouts.select{|k,v| v[:default]}.flatten
    end
		@page.layout = layout

		layout_info[:partials].each do |part|
			partial = @page.spud_page_partials.select{|p| p.name == part.strip}
      if partial.blank?
        @page.spud_page_partials.new(:name => part.strip)
      end
		end

	end

	def update

		@page.attributes = params[:spud_page]
		if params[:preview] && params[:preview].to_i == 1
			preview
			return
		end
		if @page.save
			flash[:notice] = "Page updated successfully!"
			redirect_to spud_admin_pages_url() and return
		else
			flash[:error] = "There was an error saving this page"
			render :action => "edit"
		end

	end

	def preview
    layout = @page.layout || Spud::Cms.default_page_layout
		render :action => :show,:layout => layout
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

  def page_parts
    layouts = Spud::Cms::Engine.template_parser.layouts(Spud::Core.site_config_for_id(session[:admin_site] || 0)[:short_name])
    template =  params[:template] && !params[:template].blank? ? layouts[params[:template]] : nil
    page = SpudPage.where(:id => params[:page]).includes(:spud_page_partials).first
    page = SpudPage.new if page.blank?
    old_page_partials = Array.new(page.spud_page_partials)
    new_page_partials = []
    if !template.blank?
      template[:partials].each do |page_part|
        new_page_partials << page.spud_page_partials.build(:name => page_part.strip)
      end
    else
      layout, layout_info = layouts.select{|k,v| v[:default]}.flatten
      page.layout = layout
    	layout_info[:partials].each do |part|
  			new_page_partials << page.spud_page_partials.build(:name => part)
  		end
    end
    new_page_partials.each do |partial|
      old_partial = old_page_partials.select {|pp| partial.name.strip.downcase == pp.name.strip.downcase }
      logger.debug "testing content swap"
      partial.content = old_partial[0].content if !old_partial.blank?
      logger.debug partial.content
    end

    respond_to do |format|
      format.js {
        if response.status == 200
          render(:partial => 'page_partials_form', :locals => {:spud_page_partials => new_page_partials, :remove_page_partials => old_page_partials})
        else
          render(:text => message)
        end
      }
    end
  end



private
	def load_page
		@page = SpudPage.where(:id => params[:id]).includes(:spud_page_partials).first
		if @page.blank?
			flash[:error] = "Page not found!"
			redirect_to spud_admin_pages_url() and return false
		elsif Spud::Core.multisite_mode_enabled && @page.site_id != session[:admin_site]
			flash[:warning] = "Site Context Changed. The page you were viewing is not associated with the current site. Redirected back to page selections."
			redirect_to spud_admin_pages_url() and return false
		end
		return true
	end



end
