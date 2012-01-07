class SpudMenuItem < ActiveRecord::Base
	belongs_to :parent, :polymorphic=>true
	belongs_to :page
	has_many :spud_menu_items,:as => :parent,:dependent => :destroy
	validates :name,:presence => true
	validates :parent_type,:presence => true
	validates :parent_id,:presence => true


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

	def self.options_tree_for_item(item,menu)
		items = menu.spud_menu_items
		items = items.where(["id != ?",item.id]) if !item.blank? && !item.id.blank?
			

		options = []
		items.each do |item|
		  options << ["#{item.name}",item.id]
		  options = item.options_tree(options,1,item)
		end
		return options
	end
end
