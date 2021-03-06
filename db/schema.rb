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

ActiveRecord::Schema.define(version: 20131016033900) do

  create_table "contents", force: true do |t|
    t.string   "title",                   null: false
    t.string   "subtitle"
    t.integer  "episode"
    t.text     "description"
    t.integer  "user_id",                 null: false
    t.string   "ip_address",              null: false
    t.integer  "status",      default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "content_id",             null: false
    t.text     "body",                   null: false
    t.string   "user_hash",              null: false
    t.string   "user_name"
    t.string   "ip_address",             null: false
    t.integer  "status",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "omniusers", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "omniusers", ["provider", "uid"], name: "provider_uid_key", unique: true, using: :btree

end
