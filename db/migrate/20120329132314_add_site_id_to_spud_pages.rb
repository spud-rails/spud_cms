class AddSiteIdToSpudPages < ActiveRecord::Migration
  def change
  	add_column :spud_pages, :site_id, :integer
    add_index :spud_pages,:site_id
  end
end
