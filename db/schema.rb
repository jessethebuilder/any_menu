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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131206225915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hours_availables", force: true do |t|
    t.date     "sunday_open"
    t.date     "sunday_close"
    t.date     "sunday_open2"
    t.date     "sunday_close2"
    t.integer  "menu_id"
    t.date     "monday_open"
    t.date     "monday_close"
    t.date     "monday_open2"
    t.date     "monday_close2"
    t.date     "tuesday_open"
    t.date     "tuesday_close"
    t.date     "tuesday_open2"
    t.date     "tuesday_close2"
    t.date     "wednesday_open"
    t.date     "wednesday_close"
    t.date     "wednesday_open2"
    t.date     "wednesday_close2"
    t.date     "thursday_open"
    t.date     "thursday_close"
    t.date     "thursday_open2"
    t.date     "thursday_close2"
    t.date     "friday_open"
    t.date     "friday_close"
    t.date     "friday_open2"
    t.date     "friday_close2"
    t.date     "saturday_open"
    t.date     "saturday_close"
    t.date     "saturday_open2"
    t.date     "saturday_close2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "tax_exempt"
    t.boolean  "dont_deliver"
    t.integer  "topping_list_id"
    t.integer  "section_id"
    t.float    "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "store_id"
    t.text     "section_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sectionalizations", force: true do |t|
    t.integer  "menu_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "delivers"
    t.float    "sales_tax_rate"
    t.integer  "hours_available_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topping_lists", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "toppings", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "cost"
    t.integer  "topping_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_type"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
