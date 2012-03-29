class SpudTemplate < ActiveRecord::Base
	has_many :spud_pages,:dependent => :nullify,:foreign_key => :template_id

	validates :base_layout, :presence => true
	validates :page_parts, :presence => true
	validates :name, :presence => true,:uniqueness => true

	attr_protected :site_id
	scope :site, lambda {|sid| where(:site_id => sid)}
end
