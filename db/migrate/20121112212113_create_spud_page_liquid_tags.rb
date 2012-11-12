class CreateSpudPageLiquidTags < ActiveRecord::Migration
  def change
    create_table :spud_page_liquid_tags do |t|
      t.integer :spud_page_partial_id
      t.string :tag_name
      t.string :value
      t.timestamps
    end
    add_index :spud_page_liquid_tags, [:tag_name,:value]
  end
end
