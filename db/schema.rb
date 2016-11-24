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

ActiveRecord::Schema.define(version: 20161124025753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "adminpack"

  create_table "bank_accounts", primary_key: "bank_account_id", force: :cascade do |t|
    t.string  "account_number", limit: 50, null: false
    t.string  "account_type",   limit: 50, null: false
    t.integer "teacher_id",                null: false
    t.integer "bank_id",                   null: false
  end

  add_index "bank_accounts", ["bank_account_id"], name: "index_bank_accounts_on_bank_account_id", unique: true, using: :btree

  create_table "banks", primary_key: "bank_id", force: :cascade do |t|
    t.string "bank_name", limit: 50, null: false
  end

  add_index "banks", ["bank_id"], name: "index_banks_on_bank_id", unique: true, using: :btree

  create_table "course_teachers", id: false, force: :cascade do |t|
    t.integer "course_id",  null: false
    t.integer "teacher_id", null: false
  end

  add_index "course_teachers", ["course_id"], name: "index_course_teachers_on_course_id", using: :btree
  add_index "course_teachers", ["teacher_id"], name: "index_course_teachers_on_teacher_id", using: :btree

  create_table "course_types", primary_key: "course_type_id", force: :cascade do |t|
    t.string "course_modality", limit: 50, null: false
    t.string "course_days",     limit: 50, null: false
    t.string "course_schedule", limit: 50, null: false
  end

  add_index "course_types", ["course_type_id"], name: "index_course_types_on_course_type_id", unique: true, using: :btree

  create_table "courses", primary_key: "course_id", force: :cascade do |t|
    t.string  "course_code",    limit: 50, null: false
    t.integer "course_type_id",            null: false
    t.integer "office_id",                 null: false
  end

  add_index "courses", ["course_code"], name: "index_courses_on_course_code", unique: true, using: :btree
  add_index "courses", ["course_id"], name: "index_courses_on_course_id", unique: true, using: :btree

  create_table "grades", primary_key: "grade_id", force: :cascade do |t|
    t.integer "final_grade",   null: false
    t.date    "date_assigned", null: false
    t.integer "student_id",    null: false
    t.integer "section_id",    null: false
  end

  add_index "grades", ["grade_id"], name: "index_grades_on_grade_id", unique: true, using: :btree

  create_table "items", primary_key: "item_id", force: :cascade do |t|
    t.string "item_name",  limit: 100, null: false
    t.string "item_type",  limit: 50,  null: false
    t.float  "item_price",             null: false
  end

  add_index "items", ["item_id"], name: "index_items_on_item_id", unique: true, using: :btree

  create_table "levels", primary_key: "level_id", force: :cascade do |t|
    t.string "level_description", limit: 50, null: false
  end

  add_index "levels", ["level_id"], name: "index_levels_on_level_id", unique: true, using: :btree

  create_table "movements", primary_key: "movement_id", force: :cascade do |t|
    t.string  "movement_type",   limit: 50, null: false
    t.integer "movement_amount",            null: false
    t.date    "movement_date",              null: false
    t.integer "office_id",                  null: false
    t.integer "item_id",                    null: false
  end

  add_index "movements", ["movement_id"], name: "index_movements_on_movement_id", unique: true, using: :btree

  create_table "office_items", id: false, force: :cascade do |t|
    t.integer "office_id",   null: false
    t.integer "item_id",     null: false
    t.integer "item_amount", null: false
  end

  add_index "office_items", ["item_id"], name: "index_office_items_on_item_id", using: :btree
  add_index "office_items", ["office_id"], name: "index_office_items_on_office_id", using: :btree

  create_table "offices", primary_key: "office_id", force: :cascade do |t|
    t.string "office_name", limit: 50, null: false
  end

  add_index "offices", ["office_id"], name: "index_offices_on_office_id", unique: true, using: :btree

  create_table "payments", primary_key: "payment_id", force: :cascade do |t|
    t.float   "payment_amount",                 null: false
    t.string  "payment_description", limit: 50, null: false
    t.string  "payment_method",      limit: 50, null: false
    t.string  "payment_status",      limit: 50, null: false
    t.date    "issue_date"
    t.date    "expiration_date"
    t.string  "bank",                limit: 50
    t.string  "reference_number",    limit: 50
    t.integer "user_id",                        null: false
    t.integer "student_id",                     null: false
  end

  add_index "payments", ["payment_id"], name: "index_payments_on_payment_id", unique: true, using: :btree

  create_table "providers", primary_key: "provider_id", force: :cascade do |t|
    t.string "provider_name",  limit: 150, null: false
    t.string "provider_rif",   limit: 15,  null: false
    t.string "provider_phone", limit: 15,  null: false
    t.string "provider_email", limit: 150, null: false
    t.string "manager_name",   limit: 150, null: false
  end

  add_index "providers", ["provider_email"], name: "index_providers_on_provider_email", unique: true, using: :btree
  add_index "providers", ["provider_id"], name: "index_providers_on_provider_id", unique: true, using: :btree
  add_index "providers", ["provider_rif"], name: "index_providers_on_provider_rif", unique: true, using: :btree

  create_table "sections", primary_key: "section_id", force: :cascade do |t|
    t.integer "section_capacity",                            null: false
    t.date    "start_date",                                  null: false
    t.date    "end_date",                                    null: false
    t.integer "section_hours",                               null: false
    t.integer "hours_covered",               default: 0,     null: false
    t.integer "level_id",                                    null: false
    t.integer "course_id",                                   null: false
    t.boolean "is_finished",                 default: false, null: false
    t.boolean "grades_assigned",             default: false, null: false
    t.string  "section_code",     limit: 50,                 null: false
  end

  add_index "sections", ["section_id"], name: "index_sections_on_section_id", unique: true, using: :btree

  create_table "students", primary_key: "student_id", force: :cascade do |t|
    t.string  "student_name",      limit: 150,                 null: false
    t.string  "student_cedula",    limit: 10,                  null: false
    t.string  "student_email",     limit: 150,                 null: false
    t.string  "student_phone",     limit: 15,                  null: false
    t.string  "alternative_phone", limit: 15,                  null: false
    t.boolean "has_scholarship",               default: false, null: false
    t.integer "section_id",                                    null: false
  end

  add_index "students", ["student_cedula"], name: "index_students_on_student_cedula", unique: true, using: :btree
  add_index "students", ["student_email"], name: "index_students_on_student_email", unique: true, using: :btree
  add_index "students", ["student_id"], name: "index_students_on_student_id", unique: true, using: :btree

  create_table "teacher_hours", primary_key: "teacher_hour_id", force: :cascade do |t|
    t.integer "hours_covered",                       null: false
    t.date    "date_covered",                        null: false
    t.boolean "teacher_substituted", default: false, null: false
    t.integer "teacher_id",                          null: false
    t.integer "section_id",                          null: false
    t.float   "fare_per_hour",                       null: false
  end

  add_index "teacher_hours", ["teacher_hour_id"], name: "index_teacher_hours_on_teacher_hour_id", unique: true, using: :btree

  create_table "teachers", primary_key: "teacher_id", force: :cascade do |t|
    t.string "teacher_name",   limit: 150, null: false
    t.string "teacher_email",  limit: 150, null: false
    t.string "teacher_phone",  limit: 15,  null: false
    t.string "teacher_cedula", limit: 10,  null: false
    t.hstore "teacher_wages"
    t.date   "entry_date",                 null: false
  end

  add_index "teachers", ["teacher_cedula"], name: "index_teachers_on_teacher_cedula", unique: true, using: :btree
  add_index "teachers", ["teacher_email"], name: "index_teachers_on_teacher_email", unique: true, using: :btree
  add_index "teachers", ["teacher_id"], name: "index_teachers_on_teacher_id", unique: true, using: :btree
  add_index "teachers", ["teacher_wages"], name: "index_teachers_on_teacher_wages", using: :gist

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string  "user_name",     limit: 150,                null: false
    t.string  "user_cedula",   limit: 10,                 null: false
    t.string  "user_password",                            null: false
    t.string  "access_level",  limit: 50,                 null: false
    t.boolean "has_access",                default: true, null: false
  end

  add_index "users", ["user_cedula"], name: "index_users_on_user_cedula", unique: true, using: :btree
  add_index "users", ["user_id"], name: "index_users_on_user_id", unique: true, using: :btree

  add_foreign_key "bank_accounts", "banks", primary_key: "bank_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bank_accounts", "teachers", primary_key: "teacher_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_teachers", "courses", primary_key: "course_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_teachers", "teachers", primary_key: "teacher_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "courses", "course_types", primary_key: "course_type_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "courses", "offices", primary_key: "office_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "grades", "sections", primary_key: "section_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "grades", "students", primary_key: "student_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "movements", "items", primary_key: "item_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "movements", "offices", primary_key: "office_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "office_items", "items", primary_key: "item_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "office_items", "offices", primary_key: "office_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payments", "students", primary_key: "student_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payments", "users", primary_key: "user_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sections", "courses", primary_key: "course_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sections", "levels", primary_key: "level_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "students", "sections", primary_key: "section_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teacher_hours", "sections", primary_key: "section_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teacher_hours", "teachers", primary_key: "teacher_id", on_update: :cascade, on_delete: :cascade
end
