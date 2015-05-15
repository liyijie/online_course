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

ActiveRecord::Schema.define(version: 20150513055141) do

  create_table "academies", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.text     "description"
    t.string   "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "exam_items", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "exam_items", ["exam_id"], name: "index_exam_items_on_exam_id"
  add_index "exam_items", ["question_id"], name: "index_exam_items_on_question_id"

  create_table "exams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sub_course_id"
    t.integer  "total_score"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "exams", ["sub_course_id"], name: "index_exams_on_sub_course_id"
  add_index "exams", ["user_id"], name: "index_exams_on_user_id"

  create_table "grades", force: :cascade do |t|
    t.integer  "academy_id"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.string   "index_type"
    t.string   "name"
    t.boolean  "be_right"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id"

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "signal_score"
    t.integer  "sub_course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "questions", ["sub_course_id"], name: "index_questions_on_sub_course_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_courses", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sub_courses", ["course_id"], name: "index_sub_courses_on_course_id"

  create_table "teachers", force: :cascade do |t|
    t.string   "phone",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               default: ""
    t.string   "number"
    t.string   "name"
    t.string   "avatar"
    t.string   "birthday"
    t.string   "tec_position"
    t.string   "email"
    t.string   "qualification"
    t.string   "fax"
    t.string   "final_education"
    t.string   "final_degree"
    t.string   "tec_expertise"
    t.text     "resume"
    t.text     "tec_situation"
    t.text     "tec_service"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["phone"], name: "index_teachers_on_phone", unique: true
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "phone",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               default: ""
    t.integer  "role",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["phone"], name: "index_users_on_phone", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
