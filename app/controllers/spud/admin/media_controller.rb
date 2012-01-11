class Spud::Admin::MediaController < Spud::Admin::ApplicationController
	layout 'spud/admin/cms/detail'
	add_breadcrumb "Media", :spud_admin_media_path
	before_filter :load_media,:only => [:edit,:update,:show,:destroy]
	def index
		@page_thumbnail = "spud/admin/media_thumb.png"
		@page_name = "Media"
		@media = SpudMedia.order("created_at DESC").paginate :page => params[:page]
	end

	def new
		@page_thumbnail = "spud/admin/media_thumb.png"
		@page_name = "New Media"
		add_breadcrumb "New", :new_spud_admin_medium_path
		@media = SpudMedia.new
	end

	def create
		@page_thumbnail = "spud/admin/media_thumb.png"
		@page_name = "New Media"
		add_breadcrumb "New", :new_spud_admin_medium_path
		@media = SpudMedia.new(params[:spud_media])
		if @media.save
			flash[:notice] = "File uploaded successfully"
			redirect_to spud_admin_media_url() and return
		else
			flash[:error] = "Error uploading media"
			render :action => "new"
			@error_object_name = "media"
		end
	end

	def show
		@page_thumbnail = "spud/admin/media_thumb.png"
		@page_name = "Media: #{@media.attachment_file_name}"
		add_breadcrumb @media.attachment_file_name, :new_spud_admin_media_path

	end

	def update
	end

	def destroy
		status = 500
		if @media.destroy
			status = 200
		end
		respond_to do |format|
			format.js {render :status => status}
			format.html {
				flash[:error] = "Error removing file." if status == 500
				flash[:notice] = "File successfully destroyed" if status == 200
				redirect_to spud_admin_media_url and return
			}
		end
	end
private
	def load_media
		@media = SpudMedia.where(:id => params[:id]).first
		if @media.blank?
			flash[:error] = "Media Asset not found!"
			redirect_to spud_admin_media_url() and return
		end
		
	end
end
