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

ActiveRecord::Schema.define(version: 20161001222408) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "books", force: :cascade do |t|
    t.integer  "isbn",          limit: 8
    t.string   "googleid"
    t.string   "category"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "apiLink"
    t.string   "title"
    t.integer  "user_id"
    t.string   "location"
    t.string   "publisher"
    t.string   "publishedDate"
    t.string   "author"
    t.integer  "averageRating"
    t.integer  "ratingsCount"
    t.string   "description"
    t.string   "imageurl"
  end

  add_index "books", ["user_id"], name: "index_books_on_user_id"

  create_table "books_readings", force: :cascade do |t|
    t.integer  "isbn",          limit: 8
    t.string   "googleid"
    t.string   "category"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "apiLink"
    t.string   "title"
    t.integer  "user_id"
    t.string   "publisher"
    t.string   "publishedDate"
    t.string   "author"
    t.integer  "averageRating"
    t.integer  "ratingsCount"
    t.string   "description"
    t.string   "imageurl"
  end

  add_index "books_readings", ["user_id"], name: "index_books_readings_on_user_id"

  create_table "books_reads", force: :cascade do |t|
    t.integer  "isbn",          limit: 8
    t.string   "googleid"
    t.string   "category"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "apiLink"
    t.string   "title"
    t.integer  "user_id"
    t.string   "publisher"
    t.string   "publishedDate"
    t.string   "author"
    t.integer  "averageRating"
    t.integer  "ratingsCount"
    t.string   "description"
    t.string   "imageurl"
  end

  add_index "books_reads", ["user_id"], name: "index_books_reads_on_user_id"

  create_table "books_wishlists", force: :cascade do |t|
    t.integer  "isbn",          limit: 8
    t.string   "googleid"
    t.string   "category"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "apiLink"
    t.string   "title"
    t.integer  "user_id"
    t.string   "publisher"
    t.string   "publishedDate"
    t.string   "author"
    t.integer  "averageRating"
    t.integer  "ratingsCount"
    t.string   "description"
    t.string   "imageurl"
  end

  add_index "books_wishlists", ["user_id"], name: "index_books_wishlists_on_user_id"

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "story_id"
    t.string  "title"
  end

  add_index "likes", ["story_id"], name: "index_likes_on_story_id"

  create_table "recommendations", force: :cascade do |t|
    t.integer "book_id"
    t.integer "user_id"
    t.string  "user_recommendation"
  end

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stories", ["user_id"], name: "index_stories_on_user_id"

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "gravitarhash"
    t.string   "name"
    t.string   "position"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
