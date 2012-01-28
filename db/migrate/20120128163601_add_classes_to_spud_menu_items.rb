class AddClassesToSpudMenuItems < ActiveRecord::Migration
  def change
    add_column :spud_menu_items, :classes, :string

  end
end
