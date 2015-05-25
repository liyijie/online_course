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

ActiveRecord::Schema.define(version: 20150522062015) do

  create_table "academies", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "sub_course_id"
    t.string   "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "attachments", ["sub_course_id"], name: "index_attachments_on_sub_course_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "usertable_id",     null: false
    t.string   "usertable_type",   null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment_scope"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["usertable_id", "usertable_type"], name: "index_comments_on_usertable_id_and_usertable_type"

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
    t.string   "answer"
    t.boolean  "correct"
    t.integer  "item_index"
  end

  add_index "exam_items", ["exam_id"], name: "index_exam_items_on_exam_id"
  add_index "exam_items", ["item_index"], name: "index_exam_items_on_item_index"
  add_index "exam_items", ["question_id"], name: "index_exam_items_on_question_id"

  create_table "exams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sub_course_id"
    t.integer  "total_score"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "correct_count", default: 0
    t.integer  "all_count",     default: 0
  end

  add_index "exams", ["sub_course_id"], name: "index_exams_on_sub_course_id"
  add_index "exams", ["user_id"], name: "index_exams_on_user_id"

  create_table "grades", force: :cascade do |t|
    t.integer  "specialty_id"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
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
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "correct_option"
    t.string   "correct_hint"
  end

  add_index "questions", ["sub_course_id"], name: "index_questions_on_sub_course_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.integer  "academy_id"
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
    t.string   "number"
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
    t.string   "sex"
    t.integer  "grade_id"
    t.text     "signature"
  end

  add_index "teachers", ["grade_id"], name: "index_teachers_on_grade_id"
  add_index "teachers", ["phone"], name: "index_teachers_on_phone", unique: true
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true

  create_table "user_courses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_courses", ["course_id"], name: "index_user_courses_on_course_id"
  add_index "user_courses", ["user_id"], name: "index_user_courses_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "phone",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               default: ""
    t.string   "name"
    t.string   "avatar"
    t.string   "position"
    t.string   "number"
    t.integer  "grade_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.boolean  "gender",                 default: true
    t.text     "signature"
  end

  add_index "users", ["phone"], name: "index_users_on_phone", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
