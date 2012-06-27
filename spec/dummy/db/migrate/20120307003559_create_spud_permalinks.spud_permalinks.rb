# This migration comes from spud_permalinks (originally 20120306195503)
class CreateSpudPermalinks < ActiveRecord::Migration
  def change
    create_table :spud_permalinks do |t|
      t.string :url_name
      t.string :attachment_type
      t.integer :attachment_id
      t.timestamps
    end
    add_index :spud_permalinks,[:attachment_type,:attachment_id]
  end
end
