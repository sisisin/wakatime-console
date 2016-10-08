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

ActiveRecord::Schema.define(version: 20161008110352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "editors", force: :cascade do |t|
    t.integer  "project_id",    null: false
    t.string   "name",          null: false
    t.integer  "total_seconds", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["project_id"], name: "index_editors_on_project_id", using: :btree
  end

  create_table "entities", force: :cascade do |t|
    t.integer  "project_id",    null: false
    t.string   "name",          null: false
    t.integer  "total_seconds", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["project_id"], name: "index_entities_on_project_id", using: :btree
  end

  create_table "languages", force: :cascade do |t|
    t.integer  "project_id",    null: false
    t.string   "name",          null: false
    t.integer  "total_seconds", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["project_id"], name: "index_languages_on_project_id", using: :btree
  end

  create_table "operating_systems", force: :cascade do |t|
    t.integer  "project_id",    null: false
    t.string   "name",          null: false
    t.integer  "total_seconds", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["project_id"], name: "index_operating_systems_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.date     "date"
    t.string   "name"
    t.integer  "total_seconds"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "editors", "projects"
  add_foreign_key "entities", "projects"
  add_foreign_key "languages", "projects"
  add_foreign_key "operating_systems", "projects"
end