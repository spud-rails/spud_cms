# This migration comes from spud_core (originally 20111214161011)
class CreateSpudAdminPermissions < ActiveRecord::Migration
  def change
    create_table :spud_admin_permissions do |t|
      t.integer :user_id
      t.string :name
      t.boolean :access

      t.timestamps
    end
  end
end
