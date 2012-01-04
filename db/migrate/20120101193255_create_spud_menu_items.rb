class CreateSpudMenuItems < ActiveRecord::Migration
  def change
    create_table :spud_menu_items do |t|
      t.string :parent_type
      t.integer :parent_id
      t.integer :item_type
      t.integer :spud_page_id
      t.integer :menu_order,:default => 0
      t.string :url

      t.timestamps
    end

    add_index :spud_menu_items,[:parent_type,:parent_id]
    add_index :spud_menu_items,[:menu_order]
  end
end
