class Spud::Admin::TemplatesController < Spud::Admin::ApplicationController
	layout 'spud/admin/cms/detail'
	add_breadcrumb "Templates", :spud_admin_templates_path
	before_filter :load_template,:only => [:edit,:update,:show,:destroy]
	

	def index
		@page_thumbnail = "spud/admin/templates_thumb.png"
		@page_name = "Templates"
		flash.now[:warning] = "Templates are an advanced way to create modified pages and require some experience in HTML and Ruby."
		@templates = SpudTemplate.order(:name).paginate :page => params[:page]

	end

	def new
		add_breadcrumb "New", :new_spud_admin_template_path
		@page_thumbnail = "spud/admin/templates_thumb.png"
		@page_name = "New Template"
		@template = SpudTemplate.new(:base_layout => "application",:page_parts => "Body")
	end

	def create
		add_breadcrumb "New", :new_spud_admin_template_path
		@page_thumbnail = "spud/admin/templates_thumb.png"
		@page_name = "New Template"

		@template = SpudTemplate.new(params[:spud_template])
		if @template.save
			flash[:notice] = "Template created successfully!"
			redirect_to spud_admin_templates_url() and return
		else
			flash.now[:error] = "Error creating template!"
			@error_object_name = "template"
			render :action => "new"
		end
	end

	def edit
		add_breadcrumb "Edit #{@template.name}", :edit_spud_admin_template_path
		@page_thumbnail = "spud/admin/templates_thumb.png"
		@page_name = "Edit #{@template.name}"

	end

	def update
		add_breadcrumb "Edit #{@template.name}", :edit_spud_admin_template_path
		@page_thumbnail = "spud/admin/templates_thumb.png"
		@page_name = "Edit #{@template.name}"
		if @template.update_attributes(params[:spud_template])
			flash[:notice] = "Template updated successfully"
			redirect_to spud_admin_templates_url() and return
		else
			flash.now[:error] = "Error saving template"
			render :action => "edit"
		end
	end


	def destroy
		status = 500
		if @template.destroy
			status = 200
		end
		respond_to do |format|
			format.js {render :status => status}
			format.html {
				flash[:notice] = "Template removed!" if status == 200
				flash[:error] = "Error removing Template!" if status == 500
				redirect_to spud_admin_templates_url and return
			}
		end
	end

private
	def load_template
		@template = SpudTemplate.where(:id => params[:id]).first
		if @template.blank?
			flash[:error] = "Template not found!"
			redirect_to spud_admin_templates_url and return false
		end
	end
end
