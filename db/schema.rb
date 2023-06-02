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

ActiveRecord::Schema[7.0].define(version: 2023_05_28_223638) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "revenue_id"
    t.integer "expense_id"
    t.index ["revenue_id"], name: "fk_activities_1_idx"
  end

  create_table "card_balances", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "balance"
    t.date "date"
    t.string "card_name", limit: 45
    t.index ["card_name"], name: "fk_card_balance_1_idx"
  end

  create_table "cards", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 45
    t.integer "balance_id"
    t.integer "user_id"
    t.index ["balance_id"], name: "fk_cards_2_idx"
    t.index ["name"], name: "fk_cards_2_idx1"
    t.index ["user_id"], name: "fk_cards_1_idx"
  end

  create_table "categories", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 45
  end

  create_table "expenses", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "sum"
    t.date "data"
    t.string "description", limit: 45
    t.integer "category_id"
    t.integer "user_id"
    t.integer "card_id"
    t.index ["card_id"], name: "fk_expenses_3_idx"
    t.index ["category_id"], name: "fk_expenses_1_idx"
    t.index ["user_id"], name: "fk_expenses_2_idx"
  end

  create_table "revenues", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "sum"
    t.date "data"
    t.string "description", limit: 45
    t.integer "user_id"
    t.integer "card_id"
    t.index ["card_id"], name: "fk_revenues_3_idx"
    t.index ["user_id"], name: "fk_revenues_2_idx"
  end

  create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "purpose", limit: 45
    t.string "username", default: ""
    t.date "date_of_birth"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "revenues", name: "fk_activities_1"
  add_foreign_key "card_balances", "cards", column: "card_name", primary_key: "name", name: "fk_card_balance_1"
  add_foreign_key "cards", "users", name: "fk_cards_1"
  add_foreign_key "expenses", "cards", name: "fk_expenses_3"
  add_foreign_key "expenses", "categories", name: "fk_expenses_1"
  add_foreign_key "expenses", "users", name: "fk_expenses_2"
  add_foreign_key "revenues", "cards", name: "fk_revenues_3"
  add_foreign_key "revenues", "users", name: "fk_revenues_2"
end
