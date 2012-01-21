class AddNotesToSpudPages < ActiveRecord::Migration
  def change
    add_column :spud_pages, :notes, :text
  end
end
