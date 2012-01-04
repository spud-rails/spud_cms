class SpudPage < ActiveRecord::Base
	belongs_to :spud_page
	belongs_to :spud_template,:foreign_key => :template_id
	has_many :spud_pages, :dependent => :nullify
	has_many :spud_page_partials,:dependent => :destroy
	has_many :spud_custom_fields,:as => :parent,:dependent => :destroy
	belongs_to :created_by_user,:class_name => "SpudUser",:foreign_key => :created_by
	belongs_to :updated_by_user,:class_name => "SpudUser",:foreign_key => :updated_by
	validates :name,:presence => true
	
	accepts_nested_attributes_for :spud_custom_fields
	accepts_nested_attributes_for :spud_page_partials
	scope :parent_pages,  where(:spud_page_id => nil)


	def options_tree(options,depth,current_page = nil)
		sub_pages = self.spud_pages
		sub_pages = sub_pages.where(["id != ?",current_page.id]) if !current_page.blank? && !current_page.id.blank?
	    if(sub_pages.blank?)
	      return options
	    end
	    sub_pages.each do |page|
	      options << ["#{'-'*depth} #{page.name}",page.id]
	      options = page.options_tree(options,depth+1,current_page)
	    end
	    return options
	end

	def self.options_tree_for_page(page)
		pages = SpudPage.parent_pages
		pages = pages.where(["id != ?",page.id]) if !page.blank? && !page.id.blank?
			

		options = []
		pages.each do |sub_page|
		  options << ["#{sub_page.name}",sub_page.id]
		  options = sub_page.options_tree(options,1,page)
		end
		return options
	end
end
