class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :content
      t.datetime :publish_at
      t.integer :created_by
      t.integer :updated_by
      t.string :format,:default => "html"
      t.integer :page_id
      t.string :meta_description
      t.string :meta_keywords
      t.integer :page_order
      t.integer :template_id

      t.timestamps
    end
  end
end
