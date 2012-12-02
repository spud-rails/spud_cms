class SpudSnippet < ActiveRecord::Base
  attr_accessible :content, :content_processed, :format, :name
  has_many :spud_page_liquid_tags, :as => :attachment, :dependent => :destroy

  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :site_id

  scope :site, lambda {|sid| where(:site_id => sid)}

  before_save :postprocess_content
  after_save :update_taglist
  def postprocess_content
    template = Liquid::Template.parse(self.content) # Parses and compiles the template
    self.content_processed = template.render()
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

end
