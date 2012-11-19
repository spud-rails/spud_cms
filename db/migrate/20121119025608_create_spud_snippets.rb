class CreateSpudSnippets < ActiveRecord::Migration
  def change
    create_table :spud_snippets do |t|
      t.string :name
      t.text :content
      t.string :format
      t.text :content_processed
      t.integer :site_id, :default => 0
      t.timestamps
    end

    add_index :spud_snippets, :site_id
    add_index :spud_snippets, :name
  end


end
