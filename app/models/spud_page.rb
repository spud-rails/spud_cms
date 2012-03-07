class SpudPage < ActiveRecord::Base
	searchable
	belongs_to :spud_page
	belongs_to :spud_template,:foreign_key => :template_id
	has_many :spud_pages, :dependent => :nullify
	has_many :spud_page_partials,:dependent => :destroy
	has_many :spud_permalinks,:as => :attachment, :dependent => :destroy
	belongs_to :created_by_user,:class_name => "SpudUser",:foreign_key => :created_by
	belongs_to :updated_by_user,:class_name => "SpudUser",:foreign_key => :updated_by

	before_validation :generate_url_name
	validates :name,:presence => true
	validates :url_name,:presence => true, :uniqueness => true

	accepts_nested_attributes_for :spud_page_partials, :allow_destroy => true
	scope :parent_pages,  where(:spud_page_id => nil)
	scope :published_pages, where(:published => true)
	scope :public, where(:visibility => 0)


	def self.grouped
		return all.group_by(&:spud_page_id)
	end

	# Returns an array of pages in order of heirarchy
	# 	:fitler Filters out a page by ID, and all of its children
	#   :value Pick an attribute to be used in the value field, defaults to ID
	def self.options_tree_for_page(config={})
		collection = config[:collection] || self.grouped
		level 		 = config[:level] 		 || 0
		parent_id  = config[:parent_id]  || nil
		filter 		 = config[:filter] 		 || nil
		value      = config[:value]			 || :id
		list 			 = []
		if collection[parent_id]
			collection[parent_id].each do |c|
				if filter.blank? || c.id != filter.id
					list << [level.times.collect{ '- ' }.join('') + c.name, c[value]]
					list += self.options_tree_for_page({:collection => collection, :parent_id => c.id, :level => level+1, :filter => filter})
				end
			end
		end
		return list
	end


     def generate_url_name
     	return true if self.name.blank?
     	if !self.use_custom_url_name || self.url_name.blank?
     	  url_name = ""
     	  if !self.spud_page.blank?
     	  	url_name += self.spud_page.url_name + "/"
     	  end
     	  url_name += self.name.parameterize.downcase
			if !self.use_custom_url_name
				pages = SpudPage
				
				if !self.id.blank?
					pages = pages.where("id != #{self.id}")
				end
				url_names = pages.all.collect{|p| p.url_name}

				counter = 1
				url_name_new = url_name
				while url_names.include?(url_name_new) do
		     	  	url_name_new = url_name + "-#{counter}"
		     	  	counter += 1
				end
				# url_name = url_name_new
				# Check Permalinks List

				permalink = SpudPermalink.where(:url_name => url_name_new).first
				counter = 1
				while permalink.blank? == false
				
					if permalink.attachment == self
						permalink.destroy
						permalink = nil
					else
						url_name_new = url_name + "-#{counter}"
			     	  	counter += 1
 	  					permalink = SpudPermalink.where(:url_name => url_name_new).first
					end
				end
				url_name = url_name_new
	     	end
	      if self.url_name.blank? == false && url_name != self.url_name
	      	self.spud_permalinks.create(:url_name => self.url_name)
	      end
          self.url_name = url_name
          self.use_custom_url_name = false
    	elsif self.id.to_i > 0
			page = SpudPage.where(:id => self.id).first
			if page.url_name.blank? == false && page.url_name != self.url_name
				permalink = SpudPermalink.where(:url_name => self.url_name).first
				if permalink.blank? == false
					if permalink.attachment == self
						permalink.destroy
					else
						self.errors.add :url_name, "This permalink has already been used by another page."
						return false
					end
				end
				self.spud_permalinks.create(:url_name => page.url_name)
			end
      	end
      	return true
     end

     def is_private?
     	return self.visibility == 1
     end
end
