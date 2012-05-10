class CreateSpudPagePartialRevisions < ActiveRecord::Migration
  def change
    create_table :spud_page_partial_revisions do |t|
      t.string :name
      t.text :content
      t.string :format
      t.integer :spud_page_id
      t.timestamps
    end

    add_index :spud_page_partial_revisions,[:spud_page_id,:name],:name => "revision_idx"
  end
end
