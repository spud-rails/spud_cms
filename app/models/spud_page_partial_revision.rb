class SpudPagePartialRevision < ActiveRecord::Base
	belongs_to :spud_page

	attr_accessible :name,:content,:format,:spud_page_id

  scope :for_partial, lambda {|partial| where(:spud_page_id => partial.spud_page_id, :name => partial.name)}

end
