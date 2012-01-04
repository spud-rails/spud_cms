class CreateSpudCustomFields < ActiveRecord::Migration
  def change
    create_table :spud_custom_fields do |t|
      t.string :parent_type
      t.integer :parent_id
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
