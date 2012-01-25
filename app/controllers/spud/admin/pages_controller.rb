class Spud::Admin::PagesController < Spud::Admin::ApplicationController
	layout 'spud/admin/cms/detail'
	add_breadcrumb "Pages", :spud_admin_pages_path
	belongs_to_spud_app :pages
	before_filter :load_page,:only => [:edit,:update,:show,:destroy]
	
	def index
		
		@pages = SpudPage.where(:spud_page_id => nil).order(:page_order).includes(:spud_pages).paginate :page => params[:page]
	end

	def show
			
		
		if @page.blank?
			flash[:error] = "Page not found"
			if !params[:id].blank?
				redirect_to spud_admin_pages_url() and return
			else
				return
			end
		end
		
		layout = 'application'


		if !@page.spud_template.blank?
			if !@page.spud_template.base_layout.blank?
				layout = @page.spud_template.base_layout
			end
			@inline = @page.spud_template.content
		end
		render :layout => layout
	end

	def new
		add_breadcrumb "New", :new_spud_admin_page_path

		
		@templates = SpudTemplate.all
		@page = SpudPage.new
		Spud::Cms.default_page_parts.each do |part|
			@page.spud_page_partials.new(:name => part)
		end
		
		# @page.spud_page_partials.new(:name => "Sidebar")
	end

	def create
		
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
		
		@templates = SpudTemplate.all
		if @page.spud_page_partials.blank?
			Spud::Cms.default_page_parts.each do |part|
				@page.spud_page_partials.new(:name => part)
			end
		end
		if !@page.spud_template.blank?
			@page.spud_template.page_parts.split(",").each do |part|
				partial = @page.spud_page_partials.select{|p| p.name == part}
				if partial.blank?
					@page.spud_page_partials.new(:name => part)
				end
			end
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
  
  def page_parts
    template =  params[:template] && !params[:template].blank? ? SpudTemplate.where(:id => params[:template]).first : nil
    page = SpudPage.where(:id => params[:page]).includes(:spud_page_partials).first
    page = SpudPage.new if page.blank?
    old_page_partials = Array.new(page.spud_page_partials)
    new_page_partials = []
    if !template.blank? && !template.page_parts.blank?
      template.page_parts.split(',').each do |page_part|
        new_page_partials << page.spud_page_partials.build(:name => page_part.strip)
      end
    else
    	Spud::Cms.default_page_parts.each do |part|
			new_page_partials << page.spud_page_partials.build(:name => part)
		end
      
    end
    new_page_partials.each do |partial|
      old_partial = old_page_partials.select {|pp| partial.name.strip.downcase == pp.name.strip.downcase }
      partial.content = old_partial[0].content if !old_partial.blank?
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
		@page = SpudPage.where(:id => params[:id]).includes(:spud_custom_fields,:spud_page_partials).first
		if @page.blank?
			flash[:error] = "Page not found!"
			redirect_to spud_admin_pages_url() and return false
		end
		return true
	end
end
