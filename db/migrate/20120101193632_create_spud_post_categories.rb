class CreateSpudPostCategories < ActiveRecord::Migration
  def change
    create_table :spud_post_categories do |t|
      t.integer :spud_post_id
      t.integer :spud_category_id

      t.timestamps
    end
    add_index :spud_post_categories,:spud_post_id
    add_index :spud_post_categories,:spud_category_id
  end
end
