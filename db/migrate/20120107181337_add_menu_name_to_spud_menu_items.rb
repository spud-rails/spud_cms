class AddMenuNameToSpudMenuItems < ActiveRecord::Migration
  def change
    add_column :spud_menu_items, :name, :string
  end
end
