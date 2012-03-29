class AddSiteIdToSpudMenus < ActiveRecord::Migration
  def change
  	add_column :spud_menus, :site_id, :integer
    add_index :spud_menus,:site_id
  end
end
