# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_03_051147) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.datetime "created_at", null: false
    t.bigint "job_application_id", null: false
    t.bigint "question_id", null: false
    t.datetime "updated_at", null: false
    t.index ["job_application_id"], name: "index_answers_on_job_application_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.string "status", default: "submitted", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["job_id"], name: "index_job_applications_on_job_id"
    t.index ["user_id", "job_id"], name: "index_job_applications", unique: true
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "max_salary"
    t.integer "min_salary"
    t.string "status", default: "draft"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "username"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.string "question"
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_questions_on_job_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.bigint "role_id", default: 1, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "job_applications"
  add_foreign_key "answers", "questions"
  add_foreign_key "job_applications", "jobs"
  add_foreign_key "job_applications", "users"
  add_foreign_key "jobs", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "jobs"
  add_foreign_key "users", "roles"
end
