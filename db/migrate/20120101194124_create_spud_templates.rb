class CreateSpudTemplates < ActiveRecord::Migration
  def change
    create_table :spud_templates do |t|
      t.string :name
      t.string :base_layout
      t.text :content
      t.text :page_parts # On top of Main
      t.timestamps
    end
  end
end
