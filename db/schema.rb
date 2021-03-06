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

ActiveRecord::Schema.define(version: 20140803071426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.text     "public_address"
    t.text     "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "currency"
    t.decimal  "balance",         precision: 18, scale: 8, default: 0.0
    t.decimal  "balance_btc",     precision: 18, scale: 8, default: 0.0
    t.text     "integration"
    t.text     "integration_uid"
    t.text     "notes"
    t.datetime "first_tx_at"
  end

  add_index "addresses", ["integration_uid", "integration"], name: "index_addresses_on_integration_uid_and_integration", using: :btree
  add_index "addresses", ["public_address", "currency"], name: "index_addresses_on_public_address_and_currency", using: :btree
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "announcements", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currency_conversions", force: true do |t|
    t.text     "name"
    t.integer  "cryptsy_id"
    t.decimal  "to_btc",      precision: 18, scale: 8
    t.decimal  "to_usd",      precision: 18, scale: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "to_eur",      precision: 18, scale: 8
    t.decimal  "to_jpy",      precision: 18, scale: 8
    t.decimal  "to_gbp",      precision: 18, scale: 8
    t.text     "justcoin_id"
  end

  add_index "currency_conversions", ["name"], name: "index_currency_conversions_on_name", unique: true, using: :btree

  create_table "tokens", force: true do |t|
    t.text     "token",         null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "refresh_token"
    t.datetime "expires_at"
    t.text     "provider"
    t.text     "provider_uid"
  end

  add_index "tokens", ["provider_uid", "provider"], name: "index_tokens_on_provider_uid_and_provider", unique: true, using: :btree
  add_index "tokens", ["token", "provider"], name: "index_tokens_on_token_and_provider", unique: true, using: :btree
  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id", using: :btree

  create_table "user_read_announcements", force: true do |t|
    t.integer  "user_id"
    t.integer  "announcement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_read_announcements", ["announcement_id"], name: "index_user_read_announcements_on_announcement_id", using: :btree
  add_index "user_read_announcements", ["user_id"], name: "index_user_read_announcements_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",           default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "username"
    t.boolean  "is_admin",                     default: false
    t.string   "otp_secret_key"
    t.integer  "second_factor_attempts_count", default: 0
    t.boolean  "has_two_factor_enabled",       default: false
    t.boolean  "is_subscribed",                default: true
    t.text     "email_hash"
    t.text     "last_selected_fiat"
    t.text     "last_selected_conversion"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["email_hash"], name: "index_users_on_email_hash", using: :btree
  add_index "users", ["is_admin"], name: "index_users_on_is_admin", using: :btree
  add_index "users", ["is_subscribed"], name: "index_users_on_is_subscribed", using: :btree
  add_index "users", ["otp_secret_key"], name: "index_users_on_otp_secret_key", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
