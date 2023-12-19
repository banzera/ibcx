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

ActiveRecord::Schema[7.0].define(version: 2023_12_18_173349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "username"
    t.json "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "financial_institutions", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "name", null: false
    t.string "addr", null: false
    t.string "routing", null: false
    t.string "acct", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_financial_institutions_on_tenant_id"
  end

  create_table "policies", force: :cascade do |t|
    t.string "number"
    t.string "policy_type"
    t.string "primary_insureds_name"
    t.date "dob"
    t.integer "issue_age"
    t.string "payor_name"
    t.string "status"
    t.date "issue_date"
    t.string "base_plan"
    t.string "policy_class"
    t.boolean "mec_status"
    t.string "dividend_option"
    t.string "nfo_option"
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_policies_on_account_id"
  end

  create_table "policy_details", force: :cascade do |t|
    t.bigint "retrieval_id"
    t.string "name"
    t.integer "face_amount_cents"
    t.string "face_amount_currency", default: "USD", null: false
    t.integer "annual_prem_cents"
    t.string "annual_prem_currency", default: "USD", null: false
    t.date "maturity"
    t.datetime "retrieved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["retrieval_id"], name: "index_policy_details_on_retrieval_id"
  end

  create_table "policy_financials", force: :cascade do |t|
    t.bigint "retrieval_id"
    t.integer "cash_value_cents"
    t.string "cash_value_currency", default: "USD", null: false
    t.integer "loan_payoff_cents"
    t.string "loan_payoff_currency", default: "USD", null: false
    t.integer "net_cash_value_cents"
    t.string "net_cash_value_currency", default: "USD", null: false
    t.integer "cost_basis_cents"
    t.string "cost_basis_currency", default: "USD", null: false
    t.integer "dividend_earned_cents"
    t.string "dividend_earned_currency", default: "USD", null: false
    t.date "dividend_earned_at"
    t.integer "loan_balance_cents"
    t.string "loan_balance_currency", default: "USD", null: false
    t.string "loan_interest_rate"
    t.integer "annual_premium_cents"
    t.string "annual_premium_currency", default: "USD", null: false
    t.date "paid_to"
    t.integer "stipulated_annual_premium_cents"
    t.string "stipulated_annual_premium_currency", default: "USD", null: false
    t.integer "total_premiumn_collected_cents"
    t.string "total_premiumn_collected_currency", default: "USD", null: false
    t.date "total_premiumn_collected_as_of"
    t.integer "maximum_annual_premium_limit_cents"
    t.string "maximum_annual_premium_limit_currency", default: "USD", null: false
    t.integer "minimum_annual_premium_required_cents"
    t.string "minimum_annual_premium_required_currency", default: "USD", null: false
    t.datetime "retrieved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["retrieval_id"], name: "index_policy_financials_on_retrieval_id"
  end

  create_table "premium_payments", force: :cascade do |t|
    t.bigint "policy_id"
    t.integer "amount_cents"
    t.string "amount_currency", default: "USD", null: false
    t.date "paid_at"
    t.index ["policy_id"], name: "index_premium_payments_on_policy_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "policy_id"
    t.string "request_type"
    t.jsonb "data"
    t.string "document_file_name"
    t.string "document_content_type"
    t.bigint "document_file_size"
    t.datetime "document_updated_at"
    t.index ["policy_id"], name: "index_requests_on_policy_id"
  end

  create_table "retrievals", force: :cascade do |t|
    t.bigint "policy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["policy_id"], name: "index_retrievals_on_policy_id"
  end

  create_table "users", comment: "Contains all the user login/profile information", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_admin"
    t.boolean "active", default: true
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["created_by_id"], name: "index_users_on_created_by_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["updated_by_id"], name: "index_users_on_updated_by_id"
  end

end
