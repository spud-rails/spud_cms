class SpudPost < ActiveRecord::Base
	belongs_to :created_by_user,:class_name => "SpudUser",:foreign_key => :created_by
	belongs_to :updated_by_user,:class_name => "SpudUser",:foreign_key => :updated_by
	has_many :spud_post_categories
	has_many :spud_categories,:through => :spud_post_categories
	has_many :spud_custom_fields,:as => :parent,:dependent => :destroy
end
