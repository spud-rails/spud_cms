class AddLayoutToSpudPages < ActiveRecord::Migration
  def change
    add_column :spud_pages, :layout, :string

    remove_column :spud_pages, :template_id
    drop_table :spud_templates
  end
end
