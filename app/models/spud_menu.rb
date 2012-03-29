class SpudMenu < ActiveRecord::Base
	validates :name,:presence => true
	has_many :spud_menu_items,:as => :parent,:dependent => :destroy
	has_many :spud_menu_items_combined,:class_name => "SpudMenuItem",:foreign_key => :spud_menu_id,:dependent => :destroy
	
	attr_protected :site_id
	scope :site, lambda {|sid| where(:site_id => sid)}
end
