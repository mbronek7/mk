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

ActiveRecord::Schema.define(version: 2018_11_17_073422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "executions", id: :serial, force: :cascade do |t|
    t.string "action"
    t.text "params"
    t.string "user_agent"
    t.text "referer"
    t.text "query"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_executions_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "processed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at"
  end

  create_table "readouts", id: :serial, force: :cascade do |t|
    t.string "data_type", limit: 50, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.integer "message_id", null: false
    t.index ["message_id"], name: "fki_fk_message_id"
  end

  create_table "sync_messages", id: :integer, default: nil, force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "executions", "users"
  add_foreign_key "readouts", "messages", name: "fk_message_id"
end
