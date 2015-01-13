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

ActiveRecord::Schema.define(version: 20150113161056) do

  create_table "journal_appointments", force: true do |t|
    t.integer "journal_id"
    t.integer "user_id"
    t.string  "role_name"
  end

  add_index "journal_appointments", ["journal_id", "user_id", "role_name"], name: "index_journal_appointments_journal_user_role", unique: true
  add_index "journal_appointments", ["journal_id"], name: "index_journal_appointments_on_journal_id"
  add_index "journal_appointments", ["user_id"], name: "index_journal_appointments_on_user_id"

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

  create_table "journal_reviewer_invites", force: true do |t|
    t.integer  "submission_id"
    t.integer  "user_id"
    t.string   "aasm_state"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "journal_reviewer_invites", ["submission_id", "user_id"], name: "index_journal_reviewer_invites_submission_user", unique: true
  add_index "journal_reviewer_invites", ["submission_id"], name: "index_journal_reviewer_invites_on_submission_id"
  add_index "journal_reviewer_invites", ["user_id"], name: "index_journal_reviewer_invites_on_user_id"

  create_table "journal_reviews", force: true do |t|
    t.string   "decision"
    t.text     "comment"
    t.integer  "revision_id"
    t.integer  "user_id"
    t.string   "aasm_state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "journal_reviews", ["revision_id", "user_id"], name: "index_journal_reviews_revision_user", unique: true
  add_index "journal_reviews", ["revision_id"], name: "index_journal_reviews_on_revision_id"
  add_index "journal_reviews", ["user_id"], name: "index_journal_reviews_on_user_id"

  create_table "journal_revision_decisions", force: true do |t|
    t.string   "decision"
    t.text     "comment"
    t.integer  "revision_id"
    t.integer  "user_id"
    t.string   "aasm_state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "journal_revision_decisions", ["revision_id"], name: "index_journal_revision_decisions_on_revision_id"
  add_index "journal_revision_decisions", ["user_id"], name: "index_journal_revision_decisions_on_user_id"

  create_table "journal_revisions", force: true do |t|
    t.integer  "submission_id"
    t.integer  "revision_n",    default: 0
    t.string   "aasm_state"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "journal_revisions", ["submission_id"], name: "index_journal_revisions_on_submission_id"

  create_table "journal_submission_files", force: true do |t|
    t.string   "file_data"
    t.string   "file_type"
    t.integer  "revision_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "journal_submission_files", ["revision_id", "file_type"], name: "index_journal_submission_files_revision_type", unique: true
  add_index "journal_submission_files", ["revision_id"], name: "index_journal_submission_files_on_revision_id"

  create_table "journal_submissions", force: true do |t|
    t.string   "title"
    t.text     "abstract"
    t.integer  "user_id"
    t.integer  "revision_seq",               default: 0
    t.integer  "last_created_revision_id"
    t.integer  "last_submitted_revision_id"
    t.string   "aasm_state"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
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
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
