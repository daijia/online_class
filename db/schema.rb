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

ActiveRecord::Schema.define(version: 20140606135037) do

  create_table "attendence_relationships", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendence_relationships", ["course_id"], name: "index_attendence_relationships_on_course_id"
  add_index "attendence_relationships", ["user_id"], name: "index_attendence_relationships_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "content",    default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_messages", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.integer  "course_id"
    t.integer  "category"
    t.string   "content",     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_read",     default: 0
  end

  add_index "course_messages", ["receiver_id"], name: "index_course_messages_on_receiver_id"
  add_index "course_messages", ["sender_id"], name: "index_course_messages_on_sender_id"

  create_table "courses", force: true do |t|
    t.integer  "teacher_id"
    t.string   "name"
    t.integer  "status",      default: 0
    t.integer  "category_id", default: 0
    t.integer  "kind",        default: 0
    t.string   "description", default: ""
    t.string   "reference",   default: ""
    t.string   "plan",        default: ""
    t.string   "knowledge",   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["teacher_id"], name: "index_courses_on_teacher_id"

  create_table "friend_requests", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.integer  "category",    default: 0
    t.boolean  "is_read",     default: false
    t.string   "content",     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_requests", ["receiver_id"], name: "index_friend_requests_on_receiver_id"
  add_index "friend_requests", ["updated_at"], name: "index_friend_requests_on_updated_at"

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "lessons", force: true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "description", default: ""
    t.datetime "start_time"
    t.integer  "duration"
    t.string   "homework",    default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id"

  create_table "letters", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "content",     default: ""
    t.boolean  "is_read",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.integer  "gender",          default: 0
    t.integer  "age",             default: 0
    t.integer  "degree",          default: 0
    t.string   "description",     default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
