class SpudPagePartial < ActiveRecord::Base
	belongs_to :spud_page
	validates :name,:presence => true
	attr_accessible :name, :spud_page_id, :content, :format, :content_processed
	before_save :maintain_revisions
	before_save :update_symbol_name
	before_save :postprocess_content

	def update_symbol_name
		self.symbol_name = self.name.parameterize.underscore
	end

	def symbol_name
		return @symbol_name || self.name.parameterize.underscore
	end

	def postprocess_content
		template = Liquid::Template.parse(self.content) # Parses and compiles the template
		self.content_processed = template.render('page' => self.spud_page)
	end

	def content_processed=(content)
		write_attribute(:content_processed,content)
	end

	def content_processed
		if read_attribute(:content_processed).blank?
			self.update_column(:content_processed, postprocess_content)
		end
		return read_attribute(:content_processed)
	end

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
