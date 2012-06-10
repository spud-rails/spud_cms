# This migration comes from spud_permalinks (originally 20120329135522)
class AddSiteIdToSpudPermalinks < ActiveRecord::Migration
  def change
    add_column :spud_permalinks, :site_id, :integer
    add_index :spud_permalinks,:site_id
  end
end
