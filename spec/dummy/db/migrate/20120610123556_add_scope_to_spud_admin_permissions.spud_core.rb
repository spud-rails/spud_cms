# This migration comes from spud_core (originally 20120328235431)
class AddScopeToSpudAdminPermissions < ActiveRecord::Migration
  def change
    add_column :spud_admin_permissions, :scope, :string

  end
end
