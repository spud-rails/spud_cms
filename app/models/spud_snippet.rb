class SpudSnippet < ActiveRecord::Base
  attr_accessible :content, :content_processed, :format, :name
  has_many :spud_page_liquid_tags, :as => :attachment, :dependent => :destroy

  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :site_id

  scope :site, lambda {|sid| where(:site_id => sid)}

  before_save :postprocess_content

  def postprocess_content
    template = Liquid::Template.parse(self.content) # Parses and compiles the template
    update_taglist(template)
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

end
