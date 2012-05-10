class SpudPagePartial < ActiveRecord::Base
	belongs_to :spud_page
	attr_accessible :name,:spud_page_id,:content,:format
	before_save :maintain_revisions


	def maintain_revisions
		if !self.changed.include?('content')
			return true
		end
		revision = SpudPagePartialRevision.new(:spud_page_id => self.spud_page_id,:name => self.name,:format => self.format,:content => self.content)
			revision.save
			if Spud::Cms.max_revisions > 0
				revision_count = SpudPagePartialRevision.where(:spud_page_id => self.spud_page_id,:name => self.name).count
				if revision_count > Spud::Cms.max_revisions
					revision_bye = SpudPagePartialRevision.where(:spud_page_id => self.spud_page_id,:name => self.name).order("created_at ASC").first
					revision_bye.destroy if !revision_bye.blank?
				end
			end
		return true
	end
end
