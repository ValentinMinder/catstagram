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

ActiveRecord::Schema.define(version: 20160606173242) do

  create_table "cats", force: :cascade do |t|
    t.string   "catname",     limit: 255,   null: false
    t.text     "description", limit: 65535
    t.string   "city",        limit: 255
    t.date     "birth_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "cats", ["user_id"], name: "index_cats_on_user_id", using: :btree

  create_table "cats_photos", id: false, force: :cascade do |t|
    t.integer "photo_id", limit: 4, null: false
    t.integer "cat_id",   limit: 4, null: false
  end

  add_index "cats_photos", ["photo_id", "cat_id"], name: "index_cats_photos_on_photo_id_and_cat_id", using: :btree

  create_table "hashtags", force: :cascade do |t|
    t.string   "tag",        limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hashtags_photos", id: false, force: :cascade do |t|
    t.integer "photo_id",   limit: 4, null: false
    t.integer "hashtag_id", limit: 4, null: false
  end

  add_index "hashtags_photos", ["photo_id", "hashtag_id"], name: "index_hashtags_photos_on_photo_id_and_hashtag_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "image_url",    limit: 255,               null: false
    t.text     "caption",      limit: 65535
    t.integer  "view_count",   limit: 4,     default: 0, null: false
    t.integer  "like_count",   limit: 4,     default: 0, null: false
    t.integer  "report_count", limit: 4,     default: 0, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id",      limit: 4
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255,                null: false
    t.string   "avatar_url",             limit: 255
    t.text     "biography",              limit: 65535
    t.datetime "banned_until"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cats", "users"
  add_foreign_key "photos", "users"
end
