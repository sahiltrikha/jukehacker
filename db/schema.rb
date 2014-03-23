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

ActiveRecord::Schema.define(version: 20140323193033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: true do |t|
    t.integer  "user_id"
    t.integer  "party_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", force: true do |t|
    t.integer  "host_id"
    t.string   "party_key"
    t.datetime "party_expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "party_rules", force: true do |t|
    t.integer "rule_id"
    t.integer "party_id"
  end

  create_table "played_songs", force: true do |t|
    t.integer  "party_id"
    t.integer  "song_id"
    t.integer  "user_id"
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queued_songs", force: true do |t|
    t.integer  "party_id"
    t.integer  "song_id"
    t.integer  "user_id"
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: true do |t|
    t.string   "condition"
    t.string   "banned_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: true do |t|
    t.string   "title"
    t.string   "artist"
    t.integer  "grooveshark_artist"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grooveshark_id"
    t.integer  "duration"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
  end

end
