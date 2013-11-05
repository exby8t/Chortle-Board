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

ActiveRecord::Schema.define(:version => 20131105174640) do

  create_table "administrators", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "families", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  create_table "intervals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "member_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.date     "birthdate"
    t.integer  "family_id"
    t.integer  "member_type_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "slug"
  end

  add_index "members", ["family_id"], :name => "index_members_on_family_id"
  add_index "members", ["member_type_id"], :name => "index_members_on_member_type_id"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "points"
    t.integer  "interval_id"
    t.integer  "category_id"
    t.integer  "age_limit"
    t.boolean  "is_active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "family_id"
  end

  add_index "tasks", ["category_id"], :name => "index_tasks_on_category_id"
  add_index "tasks", ["interval_id"], :name => "index_tasks_on_interval_id"

  create_table "todos", :force => true do |t|
    t.integer  "member_id"
    t.integer  "task_id"
    t.integer  "year"
    t.integer  "month"
    t.integer  "week"
    t.integer  "day"
    t.integer  "family_id"
    t.boolean  "is_completed"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "todos", ["family_id"], :name => "index_todos_on_family_id"
  add_index "todos", ["member_id"], :name => "index_todos_on_member_id"
  add_index "todos", ["task_id"], :name => "index_todos_on_task_id"

end
