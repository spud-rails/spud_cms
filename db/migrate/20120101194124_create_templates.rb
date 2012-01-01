class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :base_layout
      t.text :content

      t.timestamps
    end
  end
end
