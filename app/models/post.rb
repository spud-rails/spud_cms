class Post < ActiveRecord::Base
	belongs_to :created_by_user,:class_name => "SpudUser",:foreign_key => :created_by
	belongs_to :updated_by_user,:class_name => "SpudUser",:foreign_key => :updated_by
	has_many :post_categories
	has_many :categories,:through => :post_categories
	has_many :custom_fields,:as => :parent,:dependent => :destroy
end
