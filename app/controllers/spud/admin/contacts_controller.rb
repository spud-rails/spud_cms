class Spud::Admin::ContactsController < Spud::Admin::ApplicationController
	add_breadcrumb "Contacts", :spud_admin_media_path
	layout 'spud/admin/detail'
	def index
		@page_thumbnail = "spud/admin/contacts_thumb.png"
		@page_name = "Contacts"
		@spud_inquiries = SpudInquiry.order("created_at DESC").includes(:spud_inquiry_fields).paginate :page => params[:page]
	end

	def show
	end

	def destroy
	end
end
