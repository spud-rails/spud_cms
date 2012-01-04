class CreateSpudPages < ActiveRecord::Migration
  def change
    create_table :spud_pages do |t|
      t.string :name
      t.string :url_name
      t.datetime :publish_at
      t.integer :created_by
      t.integer :updated_by
      t.string :format,:default => "html"
      t.integer :spud_page_id
      t.text :meta_description
      t.string :meta_keywords
      t.integer :page_order
      t.integer :template_id

      t.timestamps
    end
  end
end
