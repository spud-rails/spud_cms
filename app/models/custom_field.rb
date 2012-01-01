class CustomField < ActiveRecord::Base
	belongs_to :parent,:polymorphic => true
	validates :name,:presence => true
	validates :value,:presence => true
	validates :parent_type,:presence => true
	validates :parent_id,:presence => true
end
