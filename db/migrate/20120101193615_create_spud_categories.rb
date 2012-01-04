class CreateSpudCategories < ActiveRecord::Migration
  def change
    create_table :spud_categories do |t|
      t.string :name
      t.integer :parent_category_id

      t.timestamps
    end
    add_index :spud_categories,:parent_category_id
  end
end
