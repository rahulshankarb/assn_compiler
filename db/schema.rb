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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121123001354) do

  create_table "contests", :force => true do |t|
    t.string   "name"
    t.integer  "duration"
    t.datetime "start_date"
    t.boolean  "active"
    t.string   "status"
    t.boolean  "memory_used"
    t.boolean  "run_time"
    t.boolean  "file_size"
    t.boolean  "validate"
    t.integer  "memory_used_val"
    t.integer  "run_time_val"
    t.integer  "file_size_val"
    t.integer  "validate_val"
    t.boolean  "acm"
    t.integer  "penalty_val",     :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "contests_problems", :id => false, :force => true do |t|
    t.integer "contest_id"
    t.integer "problem_id"
  end

  create_table "contests_users", :id => false, :force => true do |t|
    t.integer "contest_id"
    t.integer "user_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "problems", :force => true do |t|
    t.string   "title"
    t.integer  "time"
    t.string   "input_file_name"
    t.string   "input_content_type"
    t.integer  "input_file_size"
    t.datetime "input_updated_at"
    t.string   "output_file_name"
    t.string   "output_content_type"
    t.integer  "output_file_size"
    t.datetime "output_updated_at"
    t.string   "body_file_name"
    t.string   "body_content_type"
    t.integer  "body_file_size"
    t.datetime "body_updated_at"
    t.boolean  "active"
    t.string   "judgeSolution_file_name"
    t.string   "judgeSolution_content_type"
    t.integer  "judgeSolution_file_size"
    t.datetime "judgeSolution_updated_at"
    t.integer  "size"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "solutions", :force => true do |t|
    t.string   "language"
    t.string   "src_file_name"
    t.string   "src_content_type"
    t.integer  "src_file_size"
    t.datetime "src_updated_at"
    t.string   "output"
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "problem_id"
    t.integer  "contest_id"
    t.decimal  "solved_time"
    t.decimal  "memory_used"
    t.decimal  "run_time"
    t.decimal  "file_size"
    t.decimal  "run_time_score"
    t.decimal  "file_size_score"
    t.decimal  "score"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email",            :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "first_person"
    t.string   "second_person"
    t.string   "third_person"
    t.boolean  "admin"
    t.boolean  "active"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
