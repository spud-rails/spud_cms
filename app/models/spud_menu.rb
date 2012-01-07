class SpudMenu < ActiveRecord::Base
	validates :name,:presence => true
	has_many :spud_menu_items,:as => :parent,:dependent => :destroy
end
