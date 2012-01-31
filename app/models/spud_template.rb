class SpudTemplate < ActiveRecord::Base
	has_many :spud_pages,:dependent => :nullify,:foreign_key => :template_id

	validates :base_layout, :presence => true
	validates :page_parts, :presence => true
	validates :name, :presence => true,:uniqueness => true
end
