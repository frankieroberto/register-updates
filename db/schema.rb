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

ActiveRecord::Schema.define(version: 20171020214802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.integer "record_id", null: false
    t.text "register_code", null: false
    t.integer "number", null: false
    t.datetime "timestamp", null: false
    t.text "item_hash", null: false
    t.json "values"
    t.integer "previous_entry_id"
  end

  create_table "records", force: :cascade do |t|
    t.text "register_code", null: false
    t.text "key", null: false
    t.json "values", null: false
    t.index ["register_code", "key"], name: "index_records_on_register_code_and_key", unique: true
  end

  create_table "registers", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.text "registry", null: false
    t.text "phase", null: false
    t.text "host"
    t.index ["code"], name: "index_registers_on_code", unique: true
  end

  create_table "update_days", force: :cascade do |t|
    t.string "register_code", null: false
    t.date "day", null: false
    t.integer "records_added_count", null: false
    t.integer "records_updated_count", null: false
  end

  add_foreign_key "entries", "entries", column: "previous_entry_id"
  add_foreign_key "entries", "records"
  add_foreign_key "entries", "registers", column: "register_code", primary_key: "code"
  add_foreign_key "records", "registers", column: "register_code", primary_key: "code"
  add_foreign_key "update_days", "registers", column: "register_code", primary_key: "code"
end
