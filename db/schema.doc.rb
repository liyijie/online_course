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

ActiveRecord::Schema.define(version: 20150515031756) do

  create_table "academies", force: :cascade do |t|  #学院表
    t.integer  "school_id",  limit: 4               #学校名称
    t.string   "name",       limit: 255             #学院名称
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "number",      limit: 255         #课程编号
    t.string   "name",        limit: 255         #课程名称
    t.text     "description", limit: 65535       #课程描述
    t.string   "content",     limit: 255         #课程内容如视频pdf文件等
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "exam_items", force: :cascade do |t| #考试项
    t.integer  "exam_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "answer",      limit: 255
    t.boolean  "correct",     limit: 1
    t.integer  "item_index",  limit: 4
  end

  add_index "exam_items", ["exam_id"], name: "index_exam_items_on_exam_id", using: :btree
  add_index "exam_items", ["item_index"], name: "index_exam_items_on_item_index", using: :btree
  add_index "exam_items", ["question_id"], name: "index_exam_items_on_question_id", using: :btree

  create_table "exams", force: :cascade do |t| #考试
    t.integer  "user_id",       limit: 4       #考试用户
    t.integer  "sub_course_id", limit: 4       #所属子课程
    t.integer  "total_score",   limit: 4       #考试总分
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "correct_count", limit: 4   #正确选项数量
    t.integer  "all_count",     limit: 4   #全部选项数量
  end

  add_index "exams", ["sub_course_id"], name: "index_exams_on_sub_course_id", using: :btree
  add_index "exams", ["user_id"], name: "index_exams_on_user_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.integer  "specialty_id", limit: 4
    t.string   "name",         limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "options", force: :cascade do |t|
    t.string   "index_type",  limit: 255
    t.string   "name",        limit: 255
    t.boolean  "be_right",    limit: 1
    t.integer  "question_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.integer  "signal_score",   limit: 4
    t.integer  "sub_course_id",  limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "correct_option", limit: 255
    t.string   "correct_hint",   limit: 255
  end

  add_index "questions", ["sub_course_id"], name: "index_questions_on_sub_course_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.integer  "academy_id", limit: 4
    t.string   "name",       limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sub_courses", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.string   "name",       limit: 255
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sub_courses", ["course_id"], name: "index_sub_courses_on_course_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string   "phone",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "username",               limit: 255,   default: ""
    t.string   "number",                 limit: 255
    t.string   "name",                   limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "birthday",               limit: 255
    t.string   "tec_position",           limit: 255
    t.string   "email",                  limit: 255
    t.string   "qualification",          limit: 255
    t.string   "fax",                    limit: 255
    t.string   "final_education",        limit: 255
    t.string   "final_degree",           limit: 255
    t.string   "tec_expertise",          limit: 255
    t.text     "resume",                 limit: 65535
    t.text     "tec_situation",          limit: 65535
    t.text     "tec_service",            limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["phone"], name: "index_teachers_on_phone", unique: true, using: :btree
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "phone",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "username",               limit: 255, default: ""
    t.string   "name",                   limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "position",               limit: 255
    t.string   "number",                 limit: 255
    t.integer  "grade_id",               limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "exam_items", "exams"
  add_foreign_key "exam_items", "questions"
  add_foreign_key "exams", "sub_courses"
  add_foreign_key "exams", "users"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "sub_courses"
  add_foreign_key "sub_courses", "courses"
end
