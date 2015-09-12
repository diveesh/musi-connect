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

ActiveRecord::Schema.define(version: 20150912060123) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities_users", id: false, force: true do |t|
    t.integer "activity_id"
    t.integer "user_id"
  end

  add_index "activities_users", ["activity_id"], name: "index_activities_users_on_activity_id", using: :btree
  add_index "activities_users", ["user_id"], name: "index_activities_users_on_user_id", using: :btree

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_users", id: false, force: true do |t|
    t.integer "genre_id"
    t.integer "user_id"
  end

  add_index "genres_users", ["genre_id"], name: "index_genres_users_on_genre_id", using: :btree
  add_index "genres_users", ["user_id"], name: "index_genres_users_on_user_id", using: :btree

  create_table "instrument_skills", force: true do |t|
    t.integer  "instrument_id"
    t.integer  "user_id"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests_users", id: false, force: true do |t|
    t.integer "interest_id"
    t.integer "user_id"
  end

  add_index "interests_users", ["interest_id"], name: "index_interests_users_on_interest_id", using: :btree
  add_index "interests_users", ["user_id"], name: "index_interests_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "login_name"
    t.string   "email_address"
    t.string   "affiliation"
    t.string   "photo_file_name"
    t.string   "password_digest"
    t.string   "salt"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "instrument_info"
    t.string   "genre_info"
    t.string   "activity_info"
    t.string   "interest_info"
  end

end
