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

ActiveRecord::Schema.define(:version => 20130218175029) do

  create_table "class_codes", :force => true do |t|
    t.string   "cc"
    t.string   "description"
    t.string   "orig_desc"
    t.string   "category"
    t.string   "comments"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "details", :force => true do |t|
    t.string   "pin"
    t.string   "city"
    t.string   "township"
    t.string   "neighborhood"
    t.string   "tax_code"
    t.string   "classification"
    t.string   "current_year"
    t.integer  "current_land"
    t.integer  "current_building"
    t.integer  "prior_year"
    t.integer  "prior_land"
    t.integer  "prior_building"
    t.integer  "prior_value"
    t.integer  "current_value"
    t.string   "description"
    t.string   "res_type"
    t.string   "use"
    t.string   "apartments"
    t.string   "ext_construction"
    t.integer  "full_bath"
    t.integer  "half_bath"
    t.string   "basement"
    t.string   "attic"
    t.string   "central_air"
    t.string   "fireplace"
    t.string   "garage"
    t.integer  "age"
    t.integer  "land_size"
    t.integer  "building_size"
    t.string   "certified"
    t.float    "land_value_ratio"
    t.float    "building_value_ratio"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "details", ["pin"], :name => "index_details_on_pin"
  add_index "details", ["property_id"], :name => "index_details_on_property_id"

  create_table "myprops", :force => true do |t|
    t.string   "pin"
    t.string   "street"
    t.string   "city"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_num"
  end

  create_table "owners", :force => true do |t|
    t.string   "cc_name"
    t.string   "cc_tax_year"
    t.string   "cc_address"
    t.string   "cc_city_state_zip"
    t.integer  "recent_sale_price"
    t.string   "recent_sale_date"
    t.string   "recent_seller"
    t.string   "recent_buyer"
    t.integer  "property_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "pin"
    t.string   "recent_sale_type"
  end

  add_index "owners", ["pin"], :name => "index_owners_on_pin"

  create_table "properties", :force => true do |t|
    t.string   "pin"
    t.integer  "area"
    t.integer  "subdivision"
    t.integer  "block"
    t.integer  "parcel"
    t.integer  "unit"
    t.string   "street"
    t.string   "city"
    t.string   "country"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "neighborhood"
    t.string   "class_code"
    t.integer  "assessed_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
  end

  add_index "properties", ["block", "subdivision", "area"], :name => "index_properties_on_block_and_subdivision_and_area"
  add_index "properties", ["city"], :name => "index_properties_on_city"
  add_index "properties", ["pin"], :name => "index_properties_on_pin"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
