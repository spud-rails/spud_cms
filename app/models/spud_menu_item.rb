class SpudMenuItem < ActiveRecord::Base
	belongs_to :parent, :polymorphic=>true
	belongs_to :spud_menu
	belongs_to :spud_page
	has_many :spud_menu_items,:as => :parent,:dependent => :destroy

	validates :name,:presence => true
	validates :spud_menu_id,:presence => true
	validates :parent_type,:presence => true
	validates :parent_id,:presence => true

	def get_url
		if !self.spud_page.blank?
			return self.spud_page.url_name
		else
			return url
		end
	end

	def options_tree(options,depth,current = nil)
		sub_items = self.spud_menu_items
		sub_items = sub_items.where(["id != ?",current.id]) if !current.blank? && !current.id.blank?
	    if(sub_items.blank?)
	      return options
	    end
	    sub_items.each do |item|
	      options << ["#{'-'*depth} #{item.name}",item.id]
	      options = item.options_tree(options,depth+1,current)
	    end
	    return options
	end
	def self.grouped(menu)
		return menu.spud_menu_items_combined.group_by(&:parent_type)
	end

	# Returns an array of pages in order of heirarchy
	# 	:fitler Filters out a page by ID, and all of its children
	#   :value Pick an attribute to be used in the value field, defaults to ID
	def self.options_tree_for_item(menu,config={})
		collection = config[:collection] || self.grouped(menu)
		level 		 = config[:level] 		 || 0
		parent_id  = config[:parent_id]  || nil
		parent_type  = config[:parent_type]  || 'SpudMenu'
		filter 		 = config[:filter] 		 || nil
		value      = config[:value]			 || :id
		list 			 = []
		if parent_type == 'SpudMenu' && collection[parent_type]
			item_collection = collection['SpudMenuItem'].group_by(&:parent_id) if collection['SpudMenuItem']
			collection[parent_type].each do |c|
				if filter.blank? || c.id != filter.id
					list << [level.times.collect{ '- ' }.join('') + c.name, c[value]]
					list += self.options_tree_for_item(menu,{:collection => item_collection, :parent_id => c.id, :level => level+1, :filter => filter,:parent_type => "SpudMenuItem"})
				end
			end
		else
			if collection[parent_id]
				collection[parent_id].each do |c|
					if filter.blank? || c.id != filter.id
						list << [level.times.collect{ '- ' }.join('') + c.name, c[value]]
						list += self.options_tree_for_item(menu,{:collection => collection, :parent_id => c.id, :level => level+1, :filter => filter,:parent_type => "SpudMenuItem"})
					end
				end
			end
		end

		return list
	end

end
