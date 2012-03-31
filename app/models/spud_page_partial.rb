class SpudPagePartial < ActiveRecord::Base
	belongs_to :spud_page
	attr_accessible :name,:spud_page_id,:content,:format
end
