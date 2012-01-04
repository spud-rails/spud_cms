class AddVisibilityToSpudPages < ActiveRecord::Migration
  def change
    add_column :spud_pages, :visibility, :integer,:default => 0
    add_column :spud_pages, :published, :boolean,:default => true
  end
end
