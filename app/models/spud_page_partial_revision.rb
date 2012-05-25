class SpudPagePartialRevision < ActiveRecord::Base
	belongs_to :spud_page
	
	attr_accessible :name,:content,:format,:spud_page_id
end
