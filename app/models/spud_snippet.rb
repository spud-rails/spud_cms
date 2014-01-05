class SpudSnippet < ActiveRecord::Base
  has_many :spud_page_liquid_tags, :as => :attachment, :dependent => :destroy

  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :site_id

  scope :site, lambda {|sid| where(:site_id => sid)}

  before_save :postprocess_content
  after_save :update_taglist
  after_destroy :expire_cache
  after_touch   :expire_cache
  after_save    :expire_cache

  def postprocess_content
    rendererClass = Spud::Core.renderer(self.format)
    if rendererClass
      renderer = rendererClass.new()
      self.content_processed = renderer.render self.content
    else
      self.content_processed = content
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
    return template.render()
  end


  def update_taglist
    template = Liquid::Template.parse(self.content) # Parses and compiles the template

    self.spud_page_liquid_tags.all.each do |tag|
      tag.destroy
    end
    template.root.nodelist.each do |node|
      if !node.is_a?(String) && defined?(node.tag_name) && defined?(node.tag_value)
        self.spud_page_liquid_tags.create(:tag_name => node.tag_name,:value => node.tag_value)
      end
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
end
