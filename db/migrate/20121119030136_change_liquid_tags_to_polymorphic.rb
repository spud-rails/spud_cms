class ChangeLiquidTagsToPolymorphic < ActiveRecord::Migration
  def up
    rename_column :spud_page_liquid_tags, :spud_page_partial_id, :attachment_id
    add_column :spud_page_liquid_tags, :attachment_type, :string

    add_index :spud_page_liquid_tags, [:attachment_type,:attachment_id]

    SpudPageLiquidTag.all.each do |f|
      f.update_attributes(:attachment_type => "SpudPagePartial")
    end
  end

  def down
    rename_column :spud_page_liquid_tags, :attachment_id, :spud_page_partial_id
    remove_column :spud_page_liquid_tags, :attachment_type
  end
end
