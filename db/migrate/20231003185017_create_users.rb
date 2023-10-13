class CreateUsers < ActiveRecord::Migration[7.0]
  def change
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
end

