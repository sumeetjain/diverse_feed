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

ActiveRecord::Schema.define(version: 20170315180413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "tablefunc"

  create_table "demographics", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "demographics", ["key"], name: "index_demographics_on_key", using: :btree
  add_index "demographics", ["user_id"], name: "index_demographics_on_user_id", using: :btree
  add_index "demographics", ["value"], name: "index_demographics_on_value", using: :btree

  create_table "reports", force: :cascade do |t|
    t.string   "subject"
    t.integer  "friends_count"
    t.integer  "friends_in_report_count"
    t.text     "demographics"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "twitter_id"
  end

  add_index "reports", ["subject"], name: "index_reports_on_subject", using: :btree
  add_index "reports", ["twitter_id"], name: "index_reports_on_twitter_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "twitter_id"
    t.text     "twitter_key"
    t.text     "twitter_secret"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "twitter_username"
  end

  add_index "users", ["twitter_username"], name: "index_users_on_twitter_username", using: :btree

  add_foreign_key "demographics", "users"
  add_foreign_key "reports", "users"
end
