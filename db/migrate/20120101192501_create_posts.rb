class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :content
      t.datetime :publish_at
      t.integer :created_by
      t.integer :updated_by
      t.string :format
      t.string :tags

      t.timestamps
    end
    add_index :posts,:publish_at
  end
end
