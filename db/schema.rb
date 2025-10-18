# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_18_204406) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "field_values", force: :cascade do |t|
    t.bigint "form_entry_id", null: false
    t.bigint "form_field_id", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_entry_id", "form_field_id"], name: "index_field_values_on_form_entry_id_and_form_field_id", unique: true
    t.index ["form_entry_id"], name: "index_field_values_on_form_entry_id"
    t.index ["form_field_id"], name: "index_field_values_on_form_field_id"
  end

  create_table "form_entries", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.bigint "user_id", null: false
    t.datetime "submitted_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id", "submitted_at"], name: "index_form_entries_on_form_id_and_submitted_at"
    t.index ["form_id"], name: "index_form_entries_on_form_id"
    t.index ["user_id"], name: "index_form_entries_on_user_id"
  end

  create_table "form_fields", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.string "name", null: false
    t.string "field_type", null: false
    t.jsonb "validations", default: {}, null: false
    t.boolean "required", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id", "name"], name: "index_form_fields_on_form_id_and_name"
    t.index ["form_id"], name: "index_form_fields_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "field_values", "form_entries"
  add_foreign_key "field_values", "form_fields"
  add_foreign_key "form_entries", "forms"
  add_foreign_key "form_entries", "users"
  add_foreign_key "form_fields", "forms"
  add_foreign_key "forms", "users"
end
