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

ActiveRecord::Schema.define(version: 20160520142340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "country"
    t.string   "postcode"
    t.string   "suite"
    t.boolean  "default"
    t.string   "nickname"
    t.string   "latitude"
    t.string   "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "amenities", force: true do |t|
    t.string   "amenity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", force: true do |t|
    t.integer  "user_id"
    t.string   "announceable_type"
    t.integer  "announceable_id"
    t.text     "message"
    t.text     "sports"
    t.text     "team_ids"
    t.text     "specific_user_groups"
    t.text     "default_user_groups"
    t.boolean  "sms"
    t.boolean  "email"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "athletic_directors", force: true do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.boolean  "accepted"
    t.boolean  "rejected"
    t.string   "mobile_phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendees", force: true do |t|
    t.integer  "user_id"
    t.boolean  "yes"
    t.boolean  "maybe"
    t.boolean  "no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "attendees", ["event_id"], name: "index_attendees_on_event_id", using: :btree

  create_table "attending_teams", force: true do |t|
    t.integer  "team_id"
    t.integer  "tournament_id"
    t.boolean  "accepted"
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_accounts", force: true do |t|
    t.integer  "bankable_id",     null: false
    t.string   "bankable_type",   null: false
    t.string   "name_on_account", null: false
    t.string   "category",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificates", force: true do |t|
    t.integer  "user_id"
    t.integer  "certification_id"
    t.date     "expiration"
    t.boolean  "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
  end

  create_table "certification_badges", force: true do |t|
    t.integer  "certification_id"
    t.string   "badge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifications", force: true do |t|
    t.string   "name"
    t.string   "issuer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chatrooms", force: true do |t|
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role_type"
  end

  add_index "chatrooms", ["role_type"], name: "index_chatrooms_on_role_type", using: :btree

  create_table "classifications", force: true do |t|
    t.integer  "user_id"
    t.string   "classification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "classification"
    t.string   "abbreviation"
    t.string   "phone_number"
    t.string   "email"
    t.string   "website"
    t.string   "slug"
    t.string   "stripe_customer_id"
    t.string   "stripe_subscription_id"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "pinterest"
    t.string   "instagram"
    t.string   "foursquare"
    t.string   "youtube"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.date     "last_payment"
    t.boolean  "premium"
    t.float    "price"
    t.string   "colors"
    t.string   "mascot"
    t.string   "motto"
    t.integer  "number_of_teams"
    t.integer  "number_of_students"
    t.string   "category"
    t.integer  "founded"
    t.integer  "enrollment"
    t.integer  "faculty"
    t.text     "sports"
    t.string   "age_range"
    t.string   "gender"
    t.string   "level"
    t.string   "selection_criteria"
    t.string   "year_founded"
    t.integer  "number_of_coaches"
    t.integer  "number_of_athletes"
    t.integer  "lowest_athlete_age"
    t.integer  "oldest_athlete_age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stripe_recipient_id"
  end

  create_table "connects", force: true do |t|
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.string   "connectable_type"
    t.integer  "connectable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_messages", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "topic"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.string   "file"
    t.text     "description"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["slug"], name: "index_documents_on_slug", unique: true, using: :btree

  create_table "event_facilities", force: true do |t|
    t.integer  "event_id"
    t.integer  "facility_id"
    t.string   "facility_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_schedules", force: true do |t|
    t.integer  "event_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_schedules", ["event_id"], name: "index_event_schedules_on_event_id", using: :btree

  create_table "event_types", force: true do |t|
    t.string   "event_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sport_id"
  end

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.string   "event_type"
    t.string   "title"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "all_day"
    t.text     "description"
    t.boolean  "private"
    t.integer  "created_by"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "opponent_id"
    t.string   "opponent_type"
    t.integer  "repeat_type"
    t.date     "repeat_until"
    t.integer  "parent_id"
    t.string   "file"
    t.boolean  "registration_required"
    t.boolean  "payment_required",      default: false
  end

  add_index "events", ["eventable_id", "eventable_type"], name: "index_events_on_eventable_id_and_eventable_type", using: :btree
  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.string   "facility_type"
    t.boolean  "is_private"
    t.boolean  "publicly_visible"
    t.string   "phone_number"
    t.string   "email"
    t.string   "website"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "pinterest"
    t.string   "instagram"
    t.string   "foursquare"
    t.string   "youtube"
    t.float    "price"
    t.string   "facility_owner_type"
    t.integer  "facility_owner_id"
    t.integer  "stripe_recipient_id"
  end

  add_index "facilities", ["slug"], name: "index_facilities_on_slug", unique: true, using: :btree

  create_table "facility_links", force: true do |t|
    t.string   "facilitatable_type"
    t.integer  "facilitatable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id"
  end

  create_table "facility_types", force: true do |t|
    t.string   "facility_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fans", force: true do |t|
    t.integer  "user_id"
    t.integer  "fannable_id"
    t.string   "fannable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fans", ["fannable_id", "fannable_type"], name: "index_fans_on_fannable_id_and_fannable_type", using: :btree

  create_table "forms", force: true do |t|
    t.string   "formable_type"
    t.integer  "formable_id"
    t.string   "submittable_type"
    t.integer  "submittable_id"
    t.integer  "submitter_id"
    t.string   "stripe_customer_id"
    t.string   "stripe_subscription_id"
    t.boolean  "paid"
    t.boolean  "master"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "data"
    t.string   "object"
    t.json     "user_data",              default: {}
    t.boolean  "notify_creator"
    t.integer  "payment_type",           default: 0
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "league_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.boolean  "accepted"
    t.boolean  "rejected"
    t.string   "mobile_phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_sports", force: true do |t|
    t.integer  "sport_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "school_affiliated"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "pinterest"
    t.string   "instagram"
    t.string   "youtube"
    t.string   "email"
    t.string   "website"
    t.string   "phone_number"
    t.float    "price"
    t.string   "classification"
    t.string   "category"
    t.integer  "stripe_recipient_id"
  end

  add_index "leagues", ["name"], name: "index_leagues_on_name", using: :btree
  add_index "leagues", ["slug"], name: "index_leagues_on_slug", unique: true, using: :btree

  create_table "measurables", force: true do |t|
    t.integer  "user_id"
    t.string   "measurable"
    t.string   "result"
    t.string   "sport"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "verifications_count", default: 0, null: false
  end

  create_table "media", force: true do |t|
    t.integer  "user_id"
    t.integer  "mediable_id"
    t.string   "mediable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "url"
    t.date     "publish_date"
    t.string   "category"
  end

  add_index "media", ["mediable_id", "mediable_type"], name: "index_media_on_mediable_id_and_mediable_type", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.integer  "chatroom_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupations", force: true do |t|
    t.string   "title"
    t.string   "company"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current_job"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "online_statuses", force: true do |t|
    t.integer  "user_id"
    t.datetime "last_seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.integer  "form_id"
    t.string   "object"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parent_children", force: true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.boolean  "accepted"
  end

  create_table "payments", force: true do |t|
    t.integer "form_id"
    t.decimal "price",      precision: 5, scale: 2, default: 0.0
    t.decimal "sm_fee",     precision: 5, scale: 2, default: 0.0
    t.decimal "stripe_fee", precision: 5, scale: 2, default: 0.0
  end

  create_table "photos", force: true do |t|
    t.integer "photo_owner_id"
    t.string  "photo_owner_type"
    t.string  "image"
    t.boolean "main",             default: false
    t.text    "settings"
  end

  add_index "photos", ["photo_owner_id"], name: "index_photos_on_photo_owner_id", using: :btree
  add_index "photos", ["photo_owner_type"], name: "index_photos_on_photo_owner_type", using: :btree

  create_table "positionings", force: true do |t|
    t.integer  "position_id"
    t.integer  "positionable_id"
    t.string   "positionable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positionings", ["positionable_id", "positionable_type"], name: "index_positionings_on_positionable_id_and_positionable_type", using: :btree

  create_table "positions", force: true do |t|
    t.integer  "sport_id"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbreviation"
  end

  create_table "profile_pictures", force: true do |t|
    t.integer  "profile_picture_owner_id"
    t.string   "profile_picture_owner_type"
    t.string   "photo",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "sex"
    t.string   "hudl"
    t.string   "youtube"
    t.string   "pinterest"
    t.string   "foursquare"
    t.string   "favorite_pro_team"
    t.string   "favorite_college_team"
    t.string   "favorite_pro_athlete"
    t.string   "hobbies"
    t.string   "gyms"
    t.string   "song"
    t.text     "description"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.integer  "user_id"
    t.string   "role"
    t.integer  "roleable_id"
    t.string   "roleable_type"
    t.datetime "date_added"
    t.integer  "accepting_user_id"
    t.string   "status"
    t.string   "mobile_phone_number"
    t.string   "level"
    t.string   "nickname"
    t.string   "jersey_number"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "classification"
    t.string   "abbreviation"
    t.string   "phone_number"
    t.string   "email"
    t.string   "website"
    t.string   "slug"
    t.string   "stripe_customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "last_payment"
    t.string   "stripe_subscription_id"
    t.boolean  "premium"
    t.float    "price"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "pinterest"
    t.string   "instagram"
    t.string   "foursquare"
    t.string   "youtube"
    t.text     "description"
    t.string   "colors"
    t.string   "mascot"
    t.string   "motto"
    t.integer  "number_of_teams"
    t.integer  "number_of_students"
    t.string   "category"
    t.integer  "founded"
    t.integer  "enrollment"
    t.integer  "faculty"
    t.integer  "stripe_recipient_id"
  end

  add_index "schools", ["slug"], name: "index_schools_on_slug", unique: true, using: :btree

  create_table "selected_options", force: true do |t|
    t.integer  "user_id"
    t.integer  "form_id"
    t.integer  "option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signed_documents", force: true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.boolean  "signed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "envelope_id"
    t.string   "file"
  end

  create_table "sport_icons", force: true do |t|
    t.integer  "sport_id"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sport_photos", force: true do |t|
    t.integer  "sport_id",   null: false
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sport_photos", ["sport_id"], name: "index_sport_photos_on_sport_id", using: :btree

  create_table "sports", force: true do |t|
    t.string   "sport"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_facilities", force: true do |t|
    t.integer  "team_id"
    t.integer  "facility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_leagues", force: true do |t|
    t.integer  "team_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer  "school_id"
    t.integer  "league_id"
    t.string   "name"
    t.string   "sport"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "classification"
    t.string   "abbreviation"
    t.string   "phone_number"
    t.string   "email"
    t.string   "website"
    t.string   "stripe_customer_id"
    t.boolean  "premium"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "pinterest"
    t.string   "instagram"
    t.string   "foursquare"
    t.string   "youtube"
    t.float    "price"
    t.text     "description"
    t.string   "teamable_type"
    t.integer  "teamable_id"
    t.integer  "stripe_recipient_id"
  end

  create_table "tournaments", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "sport"
    t.string   "level"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "director_paid"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["slug"], name: "index_tournaments_on_slug", unique: true, using: :btree

  create_table "user_profile_pictures", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "photo",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_profile_pictures", ["photo"], name: "index_user_profile_pictures_on_photo", using: :btree
  add_index "user_profile_pictures", ["user_id"], name: "index_user_profile_pictures_on_user_id", using: :btree

  create_table "userless_roles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.integer  "userless_id"
    t.string   "userless_type"
    t.datetime "date_added"
    t.integer  "accepting_user_id"
    t.string   "status"
    t.string   "mobile_phone_number"
    t.string   "level"
    t.string   "nickname"
    t.string   "jersey_number"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "password_digest",         default: "", null: false
    t.string   "email"
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
    t.string   "provider"
    t.string   "uid"
    t.string   "mobile_phone_number"
    t.integer  "temporary_school_ids"
    t.integer  "signin_count",            default: 0
    t.integer  "parent_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["parent_id"], name: "index_users_on_parent_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "verifications", force: true do |t|
    t.string   "verifiable_type"
    t.integer  "verifiable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "verifications", ["verifiable_id"], name: "index_verifications_on_verifiable_id", using: :btree
  add_index "verifications", ["verifiable_type"], name: "index_verifications_on_verifiable_type", using: :btree

end
