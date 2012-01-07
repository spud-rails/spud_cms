class CreateSpudInquiryFields < ActiveRecord::Migration
  def change
    create_table :spud_inquiry_fields do |t|
      t.string :name
      t.text :value
      t.integer :spud_inquiry_id

      t.timestamps
    end

    add_index :spud_inquiry_fields,:spud_inquiry_id
  end
end
