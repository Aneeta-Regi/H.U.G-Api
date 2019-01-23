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

ActiveRecord::Schema.define(version: 20180924190846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absences", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "date"
    t.string   "recorded_by"
    t.integer  "lesson_id"
    t.string   "lesson_name"
    t.string   "lesson_identifier"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "vol_id"
  end

  create_table "app_links", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "link"
    t.integer  "sort_order"
    t.string   "icon"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "averages", force: :cascade do |t|
    t.float    "acumen_one"
    t.float    "acumen_two"
    t.integer  "mood_one"
    t.integer  "mood_two"
    t.integer  "time_one"
    t.integer  "time_two"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.integer  "district_num"
    t.string   "name"
    t.string   "state"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "dra_records", force: :cascade do |t|
    t.string   "grade"
    t.string   "school_year"
    t.integer  "fall_dra"
    t.integer  "winter_dra"
    t.integer  "spring_dra"
    t.integer  "student_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "mid_year_dra_gain"
    t.integer  "end_of_year_dra_gain"
    t.integer  "fall_rit"
    t.integer  "winter_rit"
    t.integer  "mid_year_rit_gain"
    t.integer  "spring_rit"
    t.integer  "end_of_year_rit_gain"
    t.string   "fall_lexile"
    t.string   "winter_lexile"
    t.string   "spring_lexile"
    t.integer  "fall_rank"
    t.integer  "winter_rank"
    t.integer  "mid_year_rank_gain"
    t.integer  "spring_rank"
    t.integer  "end_year_rank_gain"
    t.integer  "fall_lexile_one"
    t.integer  "winter_lexile_one"
    t.integer  "spring_lexile_one"
    t.integer  "fall_lexile_two"
    t.integer  "winter_lexile_two"
    t.integer  "spring_lexile_two"
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_name"
    t.string   "url"
    t.string   "image"
    t.integer  "school_id"
    t.string   "description"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "label"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "school_name"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "vol_name"
    t.integer  "vol_id"
    t.string   "email"
    t.integer  "mood"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "session_id"
  end

  create_table "lastuserimports", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "memberarray", default: [],              array: true
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "lesson_name"
    t.string   "summary"
    t.integer  "total_word"
    t.string   "image"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "grade_level"
    t.string   "lesson_identifier"
    t.string   "sec_image"
    t.boolean  "active",            default: true
  end

  create_table "resolutions", force: :cascade do |t|
    t.string   "user_name"
    t.string   "comment"
    t.integer  "feedback_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "school_name"
    t.string   "school_phone"
    t.string   "school_city"
    t.string   "school_state"
    t.integer  "school_zip"
    t.string   "school_district"
    t.string   "principal_name"
    t.string   "vice_principal_name"
    t.string   "clarity_person_name"
    t.string   "clarity_person_phone"
    t.string   "clarity_person_second_phone"
    t.string   "clarity_person_email"
    t.string   "notes"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "address"
    t.integer  "district_id"
  end

  create_table "schools_users", id: false, force: :cascade do |t|
    t.integer "school_id"
    t.integer "user_id"
    t.index ["school_id"], name: "index_schools_users_on_school_id", using: :btree
    t.index ["user_id"], name: "index_schools_users_on_user_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "lesson_id"
    t.integer  "word_missed"
    t.integer  "time"
    t.integer  "student_mood"
    t.string   "recorded_by"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.float    "acumen"
    t.boolean  "first_attempt",     default: true
    t.boolean  "second_attempt",    default: false
    t.datetime "date"
    t.string   "lesson_identifier"
    t.integer  "num_words_learned"
    t.string   "comments"
    t.integer  "vol_id"
    t.string   "school_year"
    t.string   "student_name"
    t.string   "grade_level"
    t.string   "school_name"
    t.integer  "school_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "class_name"
    t.integer  "school_id"
    t.string   "school_name"
    t.integer  "user_id"
    t.string   "notes"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "vol_name"
    t.string   "vol_email"
    t.integer  "zip_code"
    t.string   "clarity_person_name"
    t.string   "clarity_email"
    t.string   "clarity_phone"
    t.string   "clarity_alt_phone"
    t.integer  "vol_ids",             default: [],                 array: true
    t.boolean  "active",              default: true
    t.boolean  "graduated",           default: false
    t.string   "vol_phone"
    t.string   "grade"
    t.string   "why_inactive"
    t.string   "s_last_name"
    t.string   "second_grade_year"
    t.string   "third_grade_year"
    t.string   "other_program_notes"
    t.integer  "num_other_programs"
    t.boolean  "control_group",       default: false
    t.string   "fifth_grade_year"
  end

  create_table "users", force: :cascade do |t|
    t.string   "commitment_level"
    t.string   "phone"
    t.string   "second_phone"
    t.string   "persona"
    t.boolean  "background_check"
    t.boolean  "code_of_ethics"
    t.string   "emergency_contact_number"
    t.string   "image"
    t.string   "notes"
    t.string   "password"
    t.integer  "school_id",                default: [],                 array: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "share_phone",              default: true
    t.string   "first_name"
    t.string   "last_name"
    t.string   "e_first_name"
    t.string   "e_last_name"
    t.boolean  "specialist"
    t.boolean  "teacher_exp",              default: false
    t.boolean  "counselor_exp",            default: false
    t.boolean  "active",                   default: false
    t.boolean  "completed_shadow_days",    default: false
    t.integer  "student_matching_level"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
