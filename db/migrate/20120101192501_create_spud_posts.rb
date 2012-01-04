class CreateSpudPosts < ActiveRecord::Migration
  def change
    create_table :spud_posts do |t|
      t.string :name
      t.text :content
      t.datetime :publish_at
      t.integer :created_by
      t.integer :updated_by
      t.string :format
      t.string :tags

      t.timestamps
    end
    add_index :spud_posts,:publish_at
  end
end
