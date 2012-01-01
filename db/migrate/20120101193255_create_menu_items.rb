class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :parent_type
      t.integer :parent_id
      t.integer :item_type
      t.integer :page_id
      t.integer :menu_order,:default => 0
      t.string :url

      t.timestamps
    end

    add_index :menu_items,[:parent_type,:parent_id]
    add_index :menu_items,[:menu_order]
  end
end
