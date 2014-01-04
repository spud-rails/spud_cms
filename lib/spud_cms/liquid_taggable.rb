module Spud::LiquidTaggable
	extend ActiveSupport::Concern
	included do
		extend ClassMethods
	end
	module ClassMethods
		def liquid_taggable(options)
			@liquid_tag_name = options[:tag_name]
			@liquid_tag_id_field = options[:tag_id_field] || :name
		  after_save :expire_cache
		  after_destroy :expire_cache
		end
	end

  def expire_cache
    # Now Time to Update Parent Entries
    old_name = self.name_was
    values = [self.name]
    values << old_name if !old_name.blank?
    SpudPageLiquidTag.where(:tag_name => "snippet",:value => values).includes(:attachment).each do |tag|
      partial = tag.touch
    end
  end

  def tag_name
    	self.superclass.instance_variable_get('@liquid_tag_name')
	end
end
