class SpudTemplate < ActiveRecord::Base
	has_many :spud_pages,:dependent => :nullify
end
