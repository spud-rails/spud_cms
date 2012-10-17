class AddContentProcessedToSpudPagePartials < ActiveRecord::Migration
  def change
    add_column :spud_page_partials, :content_processed, :text
  end
end
