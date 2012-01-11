class AddUseCustomUrlNameToSpudPages < ActiveRecord::Migration
  def change
    add_column :spud_pages, :use_custom_url_name, :boolean,:default => false
  end
end
