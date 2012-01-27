class AddMenuIdToSpudMenuItems < ActiveRecord::Migration

  def change
    add_column :spud_menu_items, :spud_menu_id, :integer
    add_index :spud_menu_items,:spud_menu_id
  end
end
