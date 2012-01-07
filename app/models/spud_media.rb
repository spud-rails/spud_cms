class SpudMedia < ActiveRecord::Base
	has_attached_file :attachment,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => ":class/:id/attachment/:basename.:extension"

     def image_from_type
     	if self.attachment_content_type.blank?
     		return "spud/admin/files_thumbs/dat_thumb.png"
     	end

     	if self.attachment_content_type.match(/jpeg|jpg/)
     		return "spud/admin/files_thumbs/jpg_thumb.png"
     	end

     	

     	if self.attachment_content_type.match(/png/)
     		return "spud/admin/files_thumbs/png_thumb.png"
     	end

     	if self.attachment_content_type.match(/zip|tar|tar\.gz|gz/)
     		return "spud/admin/files_thumbs/zip_thumb.png"
     	end

     	if self.attachment_content_type.match(/xls|xlsx/)
     		return "spud/admin/files_thumbs/xls_thumb.png"
     	end
     	if self.attachment_content_type.match(/doc|docx/)
     		return "spud/admin/files_thumbs/doc_thumb.png"
     	end
     	if self.attachment_content_type.match(/ppt|pptx/)
     		return "spud/admin/files_thumbs/ppt_thumb.png"
     	end
     	if self.attachment_content_type.match(/txt|text/)
     		return "spud/admin/files_thumbs/txt_thumb.png"
     	end
     	if self.attachment_content_type.match(/pdf|ps/)
     		return "spud/admin/files_thumbs/pdf_thumb.png"
     	end
     	if self.attachment_content_type.match(/mp3|wav|aac/)
     		return "spud/admin/files_thumbs/mp3_thumb.png"
     	end

     	return "spud/admin/files_thumbs/dat_thumb.png"
     end
end
