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

ActiveRecord::Schema.define(version: 20141218150603) do

  create_table "journal_journals", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "journal_journals", ["slug"], name: "index_journal_journals_on_slug", unique: true
  add_index "journal_journals", ["user_id"], name: "index_journal_journals_on_user_id"

  create_table "journal_revisions", force: true do |t|
    t.integer  "journal_submissions_id"
    t.integer  "revision_n",             default: 0
    t.string   "aasm_state"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "journal_revisions", ["journal_submissions_id"], name: "index_journal_revisions_on_journal_submissions_id"

  create_table "journal_submissions", force: true do |t|
    t.string   "title"
    t.text     "abstract"
    t.integer  "user_id"
    t.integer  "revision_seq",            default: 0
    t.integer  "last_created_revision",   default: 0
    t.integer  "last_submitted_revision", default: 0
    t.string   "aasm_state"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "journal_id"
  end

  add_index "journal_submissions", ["journal_id"], name: "index_journal_submissions_on_journal_id"
  add_index "journal_submissions", ["user_id"], name: "index_journal_submissions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
