class SpudCategory < ActiveRecord::Base
	belongs_to :parent_category,:class_name => "SpudCategory"
	has_many :spud_categories,:foreign_key => :parent_category_id
	has_many :spud_post_categories
	has_many :spud_posts,:through => :spud_post_categories
end
