class SpudPostCategory < ActiveRecord::Base
	belongs_to :spud_category
	belongs_to :spud_post
end
