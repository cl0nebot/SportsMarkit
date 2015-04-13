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

ActiveRecord::Schema.define(version: 20150413123509) do

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "height_ft"
    t.integer  "height_in"
    t.integer  "weight"
    t.date     "date_of_birth"
    t.string   "level"
    t.string   "guardian"
    t.string   "guardian_phone_number"
    t.string   "linkedin"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "twitter"
    t.string   "elementary_school"
    t.string   "middle_school"
    t.string   "highschool"
    t.string   "undergraduate_school"
    t.string   "graduate_school"
    t.string   "doctorate_school"
    t.string   "undergraduate_degree"
    t.string   "graduate_degree"
    t.string   "doctorate_degree"
    t.string   "undergraduate_major"
    t.string   "graduate_major"
    t.string   "doctorate_major"
    t.integer  "undergraduate_year"
    t.integer  "graduate_year"
    t.integer  "doctorate_year"
    t.string   "city"
    t.string   "offseason_city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "mobile_phone_number"
    t.string   "focus"
    t.string   "specialties"
    t.string   "skills"
    t.string   "injuries"
    t.string   "current_ailments"
    t.string   "category"
    t.string   "company"
    t.string   "website"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "classification"
    t.string   "abbreviation"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "zip_ext"
    t.float    "latitude",           limit: 24
    t.float    "longitude",          limit: 24
    t.boolean  "gmaps"
    t.string   "phone_number"
    t.string   "email"
    t.string   "website"
    t.string   "slug"
    t.string   "stripe_customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["slug"], name: "index_schools_on_slug", unique: true, using: :btree

  create_table "user_profile_pictures", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "photo",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_profile_pictures", ["photo"], name: "index_user_profile_pictures_on_photo", using: :btree
  add_index "user_profile_pictures", ["user_id"], name: "index_user_profile_pictures_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "password_digest",         default: "", null: false
    t.string   "email",                   default: "", null: false
    t.string   "username"
    t.string   "prefix"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "authentication_token"
    t.string   "slug"
    t.boolean  "admin"
    t.string   "categories"
    t.integer  "invited_by_id"
    t.integer  "invitation_count"
    t.string   "stripe_customer_id"
    t.string   "stripe_recipient_id"
    t.string   "stripe_subscription_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
