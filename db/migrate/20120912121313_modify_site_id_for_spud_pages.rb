class ModifySiteIdForSpudPages < ActiveRecord::Migration
  def up
    change_column :spud_pages,:site_id,:integer,:default => 0,:null => false
    change_column :spud_templates,:site_id,:integer,:default => 0,:null => false
    change_column :spud_menus,:site_id,:integer,:default => 0,:null => false
    SpudPage.where(:site_id => nil).each {|f| f.site_id = 0 ; f.save}
    SpudMenu.where(:site_id => nil).each {|f| f.site_id = 0 ; f.save}
  end

  def down
    change_column :spud_pages,:site_id,:integer,:default => nil,:null => true
    change_column :spud_templates,:site_id,:integer,:default => nil,:null => true
    change_column :spud_menus,:site_id,:integer,:default => nil,:null => true
  end
end
