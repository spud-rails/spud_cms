class SpudMenu < ActiveRecord::Base
	validates :name,:presence => true, :uniqueness => [:site_id]

	has_many :spud_menu_items,:as => :parent,:dependent => :destroy
	has_many :spud_menu_items_combined,:class_name => "SpudMenuItem",:foreign_key => :spud_menu_id,:dependent => :destroy


	scope :site, lambda {|sid| where(:site_id => sid)}
end
