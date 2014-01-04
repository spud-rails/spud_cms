class SpudPagePartial < ActiveRecord::Base
	belongs_to :spud_page, :touch => true
	has_many :spud_page_liquid_tags, :as => :attachment, :dependent => :destroy
	validates :name,:presence => true
	before_save :maintain_revisions
	before_save :update_symbol_name
	before_save :postprocess_content
	after_save :update_taglist


	def update_symbol_name
		self.symbol_name = self.name.parameterize.underscore
	end

	def symbol_name
		return @symbol_name || self.name.parameterize.underscore
	end

	def postprocess_content
		rendererClass = Spud::Core.renderer(self.format)
		if rendererClass
			renderer = rendererClass.new()
			self.content_processed = renderer.render self.content
		else
			self.content_processed = content
		end
		# template = Liquid::Template.parse(self.content) # Parses and compiles the template

		# self.content_processed = template.render('page' => self.spud_page)
	end

	def update_taglist
		template = Liquid::Template.parse(self.content) # Parses and compiles the template

		self.spud_page_liquid_tags.each do |tag|
			tag.destroy
		end
		template.root.nodelist.each do |node|
			if !node.is_a?(String) && defined?(node.tag_name) && defined?(node.tag_value)
				self.spud_page_liquid_tags.create(:tag_name => node.tag_name,:value => node.tag_value)
			end
		end
	end

	def content_processed=(content)
		write_attribute(:content_processed,content)
	end

	def content_processed
		if read_attribute(:content_processed).blank?
			self.update_column(:content_processed, postprocess_content)
		end
		template = Liquid::Template.parse(read_attribute(:content_processed)) # Parses and compiles the template

		return template.render('page' => self.spud_page)
	end

	def maintain_revisions
		if self.changed.include?('content')
			revision = SpudPagePartialRevision.create(:spud_page_id => self.spud_page_id,:name => self.name,:format => self.format,:content => self.content)
			drop_old_revisions if Spud::Cms.max_revisions > 0
		end

		return true
	end

private

	def drop_old_revisions
		revision_count = SpudPagePartialRevision.for_partial(self).count
		if revision_count > Spud::Cms.max_revisions
			revision_bye = SpudPagePartialRevision.for_partial(self).order("created_at ASC").first
			revision_bye.destroy if !revision_bye.blank?
		end
	end
end
