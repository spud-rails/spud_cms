# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121112151110) do

  create_table "spud_admin_permissions", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "access"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "scope"
  end

  create_table "spud_menu_items", :force => true do |t|
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "item_type"
    t.integer  "spud_page_id"
    t.integer  "menu_order",   :default => 0
    t.string   "url"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "name"
    t.integer  "spud_menu_id"
    t.string   "classes"
  end

  add_index "spud_menu_items", ["menu_order"], :name => "index_spud_menu_items_on_menu_order"
  add_index "spud_menu_items", ["parent_type", "parent_id"], :name => "index_spud_menu_items_on_parent_type_and_parent_id"
  add_index "spud_menu_items", ["spud_menu_id"], :name => "index_spud_menu_items_on_spud_menu_id"

  create_table "spud_menus", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "site_id",     :default => 0, :null => false
  end

  add_index "spud_menus", ["site_id"], :name => "index_spud_menus_on_site_id"

  create_table "spud_page_partial_revisions", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "format"
    t.integer  "spud_page_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "spud_page_partial_revisions", ["spud_page_id", "name"], :name => "revision_idx"

  create_table "spud_page_partials", :force => true do |t|
    t.integer  "spud_page_id"
    t.string   "name"
    t.text     "content"
    t.string   "format"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "symbol_name"
    t.text     "content_processed"
  end

  add_index "spud_page_partials", ["spud_page_id"], :name => "index_spud_page_partials_on_spud_page_id"

  create_table "spud_pages", :force => true do |t|
    t.string   "name"
    t.string   "url_name"
    t.datetime "publish_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "format",              :default => "html"
    t.integer  "spud_page_id"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.integer  "page_order"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "visibility",          :default => 0
    t.boolean  "published",           :default => true
    t.boolean  "use_custom_url_name", :default => false
    t.text     "notes"
    t.integer  "site_id",             :default => 0,      :null => false
    t.string   "layout"
  end

  add_index "spud_pages", ["site_id"], :name => "index_spud_pages_on_site_id"

  create_table "spud_permalinks", :force => true do |t|
    t.string   "url_name"
    t.string   "attachment_type"
    t.integer  "attachment_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "site_id"
  end

  add_index "spud_permalinks", ["attachment_type", "attachment_id"], :name => "index_spud_permalinks_on_attachment_type_and_attachment_id"
  add_index "spud_permalinks", ["site_id"], :name => "index_spud_permalinks_on_site_id"

  create_table "spud_user_settings", :force => true do |t|
    t.integer  "spud_user_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "spud_users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "super_admin"
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "time_zone"
  end

  add_index "spud_users", ["email"], :name => "index_spud_users_on_email"
  add_index "spud_users", ["login"], :name => "index_spud_users_on_login"

end
