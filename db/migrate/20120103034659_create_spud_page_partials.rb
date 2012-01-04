class CreateSpudPagePartials < ActiveRecord::Migration
  def change
    create_table :spud_page_partials do |t|
      t.integer :spud_page_id
      t.string :name
      t.text :content
      t.string :format

      t.timestamps
    end
    add_index :spud_page_partials,:spud_page_id
  end
end
