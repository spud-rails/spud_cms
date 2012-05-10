class SpudPagePartialRevision < ActiveRecord::Base
	belongs_to :spud_page
	
  # attr_accessible :title, :body
end
