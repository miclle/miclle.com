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

ActiveRecord::Schema.define(version: 20131230152527) do

  create_table "albums", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.integer  "photo_count"
    t.string   "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["name"], name: "index_albums_on_name", using: :btree
  add_index "albums", ["privacy"], name: "index_albums_on_privacy", using: :btree
  add_index "albums", ["user_id"], name: "index_albums_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.text     "content"
    t.datetime "deleted_at"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["entity_id"], name: "index_comments_on_entity_id", using: :btree
  add_index "comments", ["entity_type"], name: "index_comments_on_entity_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.string   "favoriteable_type"
    t.integer  "favoriteable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["favoriteable_id"], name: "index_favorites_on_favoriteable_id", using: :btree
  add_index "favorites", ["favoriteable_type"], name: "index_favorites_on_favoriteable_type", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "invitations", force: true do |t|
    t.integer  "user_id"
    t.integer  "invitee"
    t.string   "code"
    t.boolean  "available"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["available"], name: "index_invitations_on_available", using: :btree
  add_index "invitations", ["code"], name: "index_invitations_on_code", unique: true, using: :btree
  add_index "invitations", ["invitee"], name: "index_invitations_on_invitee", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likeable_id"], name: "index_likes_on_likeable_id", using: :btree
  add_index "likes", ["likeable_type"], name: "index_likes_on_likeable_type", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.string   "image"
    t.string   "name"
    t.text     "description"
    t.string   "category"
    t.string   "privacy"
    t.string   "state"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.text     "tag_cache"
    t.string   "camera"
    t.integer  "focal_length"
    t.string   "exposure_time"
    t.float    "aperture"
    t.integer  "iso"
    t.string   "license"
    t.boolean  "is_adult_content"
    t.decimal  "latitude",                    precision: 15, scale: 6
    t.decimal  "longitude",                   precision: 15, scale: 6
    t.datetime "taken_at"
    t.integer  "editor_id"
    t.integer  "view_count"
    t.integer  "like_count"
    t.integer  "favorite_count"
    t.string   "uuid",             limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree
  add_index "photos", ["category"], name: "index_photos_on_category", using: :btree
  add_index "photos", ["editor_id"], name: "index_photos_on_editor_id", using: :btree
  add_index "photos", ["name"], name: "index_photos_on_name", using: :btree
  add_index "photos", ["privacy"], name: "index_photos_on_privacy", using: :btree
  add_index "photos", ["state"], name: "index_photos_on_state", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "username",                          default: "", null: false
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "role",                   limit: 32
    t.string   "avatar"
    t.string   "title"
    t.string   "invitation_code"
    t.string   "name"
    t.string   "gender",                 limit: 8
    t.string   "city"
    t.string   "bio"
    t.string   "website"
    t.string   "weibo"
    t.string   "twitter"
    t.integer  "qq"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                   default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                   limit: 32
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["title"], name: "index_users_on_title", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree
  add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree

end
