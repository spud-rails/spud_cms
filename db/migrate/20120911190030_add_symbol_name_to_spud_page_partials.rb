class AddSymbolNameToSpudPagePartials < ActiveRecord::Migration
  def change
    add_column :spud_page_partials, :symbol_name, :string
  end
end
