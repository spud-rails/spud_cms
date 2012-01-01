class Category < ActiveRecord::Base
	belongs_to :parent_category,:class_name => "Category"
	has_many :categories,:foreign_key => :parent_category_id
	has_many :post_categories
	has_many :posts,:through => :post_categories
end
