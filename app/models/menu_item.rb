class MenuItem < ActiveRecord::Base
	belongs_to :parent, :polymorphic=>true
	belongs_to :page
	vaidates :name,:presence => true
	validates :item_type,:presence => true
	validates :parent_type,:presence => true
	validates :parent_id,:presence => true
end
