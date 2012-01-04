class CreateSpudMenus < ActiveRecord::Migration
  def change
    create_table :spud_menus do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
