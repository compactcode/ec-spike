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

ActiveRecord::Schema.define(version: 20160922004856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "external_id"
    t.integer  "balance"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["customer_id"], name: "index_accounts_on_customer_id", using: :btree
    t.index ["external_id"], name: "index_accounts_on_external_id", unique: true, using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "uuid"
    t.boolean  "wants_notifications"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "phone_number"
    t.index ["customer_id"], name: "index_devices_on_customer_id", using: :btree
    t.index ["phone_number"], name: "index_devices_on_phone_number", unique: true, using: :btree
  end

  add_foreign_key "accounts", "customers"
  add_foreign_key "devices", "customers"
end
