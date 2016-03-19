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

ActiveRecord::Schema.define(version: 0) do

  create_table "bank_accounts", primary_key: "bank_account_id", force: :cascade do |t|
    t.string  "account_number", limit: 50, null: false
    t.string  "account_type",   limit: 50, null: false
    t.integer "teacher_id",     limit: 4,  null: false
    t.integer "bank_id",        limit: 4,  null: false
  end

  add_index "bank_accounts", ["bank_account_id"], name: "bank_account_id_UNIQUE", unique: true, using: :btree
  add_index "bank_accounts", ["bank_id"], name: "fk_bank_accounts_banks1_idx", using: :btree
  add_index "bank_accounts", ["teacher_id"], name: "fk_bank_accounts_teachers1_idx", using: :btree

  create_table "banks", primary_key: "bank_id", force: :cascade do |t|
    t.string "bank_name", limit: 100, null: false
  end

  add_index "banks", ["bank_id"], name: "bank_id_UNIQUE", unique: true, using: :btree

  create_table "course_teachers", id: false, force: :cascade do |t|
    t.integer "courses_course_id",   limit: 4, null: false
    t.integer "teachers_teacher_id", limit: 4, null: false
  end

  add_index "course_teachers", ["courses_course_id"], name: "fk_courses_has_teachers_courses1_idx", using: :btree
  add_index "course_teachers", ["teachers_teacher_id"], name: "fk_courses_has_teachers_teachers1_idx", using: :btree

  create_table "course_types", primary_key: "course_type_id", force: :cascade do |t|
    t.string "course_name",     limit: 50, null: false
    t.string "course_days",     limit: 50, null: false
    t.string "course_schedule", limit: 50, null: false
  end

  add_index "course_types", ["course_type_id"], name: "course_type_id_UNIQUE", unique: true, using: :btree

  create_table "courses", primary_key: "course_id", force: :cascade do |t|
    t.string  "course_code",     limit: 50,             null: false
    t.string  "course_level",    limit: 50,             null: false
    t.integer "course_capacity", limit: 4,              null: false
    t.date    "start_date",                             null: false
    t.date    "completion_date",                        null: false
    t.integer "course_hours",    limit: 4,              null: false
    t.integer "hours_covered",   limit: 4,  default: 0, null: false
    t.integer "course_type_id",  limit: 4,              null: false
    t.integer "office_id",       limit: 4,              null: false
  end

  add_index "courses", ["course_id"], name: "course_id_UNIQUE", unique: true, using: :btree
  add_index "courses", ["course_type_id"], name: "fk_courses_course_types1_idx", using: :btree
  add_index "courses", ["office_id"], name: "fk_courses_offices1_idx", using: :btree

  create_table "fees", primary_key: "fee_id", force: :cascade do |t|
    t.float   "fee_amount",       limit: 24,  null: false
    t.string  "payment_type",     limit: 50,  null: false
    t.date    "issue_date",                   null: false
    t.date    "expiration_date",              null: false
    t.string  "bank",             limit: 50
    t.string  "reference_number", limit: 50
    t.string  "fee_status",       limit: 50,  null: false
    t.string  "fee_description",  limit: 200, null: false
    t.integer "user_id",          limit: 4,   null: false
    t.integer "student_id",       limit: 4,   null: false
  end

  add_index "fees", ["fee_id"], name: "fee_id_UNIQUE", unique: true, using: :btree
  add_index "fees", ["student_id"], name: "fk_fees_students1_idx", using: :btree
  add_index "fees", ["user_id"], name: "fk_fees_users1_idx", using: :btree

  create_table "grades", primary_key: "grade_id", force: :cascade do |t|
    t.integer "grade",      limit: 4, null: false
    t.date    "grade_date",           null: false
    t.integer "student_id", limit: 4, null: false
    t.integer "course_id",  limit: 4, null: false
  end

  add_index "grades", ["course_id"], name: "fk_grades_courses1_idx", using: :btree
  add_index "grades", ["grade_id"], name: "grade_id_UNIQUE", unique: true, using: :btree
  add_index "grades", ["student_id"], name: "fk_grades_students1_idx", using: :btree

  create_table "items", primary_key: "item_id", force: :cascade do |t|
    t.string  "item_name",   limit: 100, null: false
    t.integer "item_amount", limit: 4,   null: false
    t.string  "item_type",   limit: 50,  null: false
    t.float   "item_price",  limit: 24,  null: false
  end

  add_index "items", ["item_id"], name: "item_id_UNIQUE", unique: true, using: :btree

  create_table "movements", primary_key: "movement_id", force: :cascade do |t|
    t.string  "movement_type",   limit: 50, null: false
    t.integer "movement_amount", limit: 4,  null: false
    t.date    "movement_date",              null: false
    t.integer "item_id",         limit: 4,  null: false
    t.integer "office_id",       limit: 4,  null: false
  end

  add_index "movements", ["item_id"], name: "fk_movements_items1_idx", using: :btree
  add_index "movements", ["movement_id"], name: "movement_id_UNIQUE", unique: true, using: :btree
  add_index "movements", ["office_id"], name: "fk_movements_offices1_idx", using: :btree

  create_table "office_items", id: false, force: :cascade do |t|
    t.integer "offices_office_id", limit: 4, null: false
    t.integer "items_item_id",     limit: 4, null: false
  end

  add_index "office_items", ["items_item_id"], name: "fk_offices_has_items_items1_idx", using: :btree
  add_index "office_items", ["offices_office_id"], name: "fk_offices_has_items_offices1_idx", using: :btree

  create_table "offices", primary_key: "office_id", force: :cascade do |t|
    t.string "office_name", limit: 75, null: false
  end

  add_index "offices", ["office_id"], name: "office_id_UNIQUE", unique: true, using: :btree

  create_table "providers", primary_key: "provider_id", force: :cascade do |t|
    t.string "provider_name",  limit: 150, null: false
    t.string "provider_rif",   limit: 15,  null: false
    t.string "provider_phone", limit: 15,  null: false
    t.string "provider_email", limit: 150, null: false
    t.string "manager",        limit: 150, null: false
  end

  add_index "providers", ["provider_email"], name: "provider_email_UNIQUE", unique: true, using: :btree
  add_index "providers", ["provider_id"], name: "provider_id_UNIQUE", unique: true, using: :btree
  add_index "providers", ["provider_rif"], name: "provider_rif_UNIQUE", unique: true, using: :btree

  create_table "signups", primary_key: "signup_id", force: :cascade do |t|
    t.float   "signup_amount",      limit: 24,  null: false
    t.string  "payment_type",       limit: 50,  null: false
    t.date    "issue_date",                     null: false
    t.date    "expiration_date",                null: false
    t.string  "bank",               limit: 50
    t.string  "reference_number",   limit: 50
    t.string  "signup_status",      limit: 50,  null: false
    t.string  "signup_description", limit: 200, null: false
    t.integer "user_id",            limit: 4,   null: false
    t.integer "student_id",         limit: 4,   null: false
  end

  add_index "signups", ["signup_id"], name: "signup_id_UNIQUE", unique: true, using: :btree
  add_index "signups", ["student_id"], name: "fk_signups_students1_idx", using: :btree
  add_index "signups", ["user_id"], name: "fk_signups_users1_idx", using: :btree

  create_table "students", primary_key: "student_id", force: :cascade do |t|
    t.string  "student_name",   limit: 150, null: false
    t.string  "student_email",  limit: 150, null: false
    t.string  "student_phone",  limit: 15,  null: false
    t.string  "student_cedula", limit: 10,  null: false
    t.integer "course_id",      limit: 4,   null: false
  end

  add_index "students", ["course_id"], name: "fk_students_courses1_idx", using: :btree
  add_index "students", ["student_cedula"], name: "student_cedula_UNIQUE", unique: true, using: :btree
  add_index "students", ["student_email"], name: "student_email_UNIQUE", unique: true, using: :btree
  add_index "students", ["student_id"], name: "ID_UNIQUE", unique: true, using: :btree

  create_table "teacher_hours", primary_key: "teacher_hour_id", force: :cascade do |t|
    t.integer "hours_covered", limit: 4, null: false
    t.date    "date_covered",            null: false
    t.integer "teacher_id",    limit: 4, null: false
    t.integer "course_id",     limit: 4, null: false
  end

  add_index "teacher_hours", ["course_id"], name: "fk_teachers_hours_courses1_idx", using: :btree
  add_index "teacher_hours", ["teacher_hour_id"], name: "hours_id_UNIQUE", unique: true, using: :btree
  add_index "teacher_hours", ["teacher_id"], name: "fk_teachers_hours_teachers1_idx", using: :btree

  create_table "teachers", primary_key: "teacher_id", force: :cascade do |t|
    t.string "teacher_name",   limit: 150, null: false
    t.string "teacher_email",  limit: 150, null: false
    t.string "teacher_phone",  limit: 15,  null: false
    t.string "teacher_cedula", limit: 10,  null: false
    t.float  "teacher_wage",   limit: 24,  null: false
    t.date   "entry_date",                 null: false
  end

  add_index "teachers", ["teacher_cedula"], name: "teacher_cedula_UNIQUE", unique: true, using: :btree
  add_index "teachers", ["teacher_email"], name: "teacher_email_UNIQUE", unique: true, using: :btree
  add_index "teachers", ["teacher_id"], name: "teacher_id_UNIQUE", unique: true, using: :btree

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string "user_name",     limit: 150, null: false
    t.string "user_cedula",   limit: 10,  null: false
    t.string "user_password", limit: 255, null: false
    t.string "access_level",  limit: 50,  null: false
  end

  add_index "users", ["user_cedula"], name: "user_cedula_UNIQUE", unique: true, using: :btree
  add_index "users", ["user_id"], name: "user_id_UNIQUE", unique: true, using: :btree

  add_foreign_key "bank_accounts", "banks", primary_key: "bank_id", name: "fk_bank_accounts_banks1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bank_accounts", "teachers", primary_key: "teacher_id", name: "fk_bank_accounts_teachers1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_teachers", "courses", column: "courses_course_id", primary_key: "course_id", name: "fk_courses_has_teachers_courses1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_teachers", "teachers", column: "teachers_teacher_id", primary_key: "teacher_id", name: "fk_courses_has_teachers_teachers1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "courses", "course_types", primary_key: "course_type_id", name: "fk_courses_course_types1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "courses", "offices", primary_key: "office_id", name: "fk_courses_offices1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fees", "students", primary_key: "student_id", name: "fk_fees_students1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fees", "users", primary_key: "user_id", name: "fk_fees_users1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "grades", "courses", primary_key: "course_id", name: "fk_grades_courses1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "grades", "students", primary_key: "student_id", name: "fk_grades_students1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "movements", "items", primary_key: "item_id", name: "fk_movements_items1"
  add_foreign_key "movements", "offices", primary_key: "office_id", name: "fk_movements_offices1"
  add_foreign_key "office_items", "items", column: "items_item_id", primary_key: "item_id", name: "fk_offices_has_items_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "office_items", "offices", column: "offices_office_id", primary_key: "office_id", name: "fk_offices_has_items_offices1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "signups", "students", primary_key: "student_id", name: "fk_signups_students1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "signups", "users", primary_key: "user_id", name: "fk_signups_users1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "students", "courses", primary_key: "course_id", name: "fk_students_courses1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teacher_hours", "courses", primary_key: "course_id", name: "fk_teachers_hours_courses1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teacher_hours", "teachers", primary_key: "teacher_id", name: "fk_teachers_hours_teachers1", on_update: :cascade, on_delete: :cascade
end
