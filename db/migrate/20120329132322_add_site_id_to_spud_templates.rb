class AddSiteIdToSpudTemplates < ActiveRecord::Migration
  def change
  	add_column :spud_templates, :site_id, :integer
    add_index :spud_templates,:site_id
  end
end
