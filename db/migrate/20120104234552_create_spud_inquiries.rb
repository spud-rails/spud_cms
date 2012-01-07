class CreateSpudInquiries < ActiveRecord::Migration
  def change
    create_table :spud_inquiries do |t|
      t.string :email
      t.timestamps
    end
  end
end
