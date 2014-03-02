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

ActiveRecord::Schema.define(version: 20140219111340) do

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "information", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "surname"
    t.date     "date_of_birth"
    t.string   "andress"
    t.string   "city"
    t.string   "country"
    t.string   "post_code"
    t.string   "phone"
    t.decimal  "credit",                 precision: 10, scale: 2, default: 0.0, null: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "information", ["user_id"], name: "index_information_on_user_id"

  create_table "line_items", force: true do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.decimal  "qnt",        precision: 7, scale: 3, default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "status_id",                           default: 1
    t.string   "name"
    t.string   "surname"
    t.string   "andress"
    t.string   "city"
    t.string   "country"
    t.string   "post_code"
    t.decimal  "expense",    precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["status_id"], name: "index_orders_on_status_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "products", force: true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.decimal  "qnt",                    precision: 7,  scale: 3
    t.decimal  "price",                  precision: 10, scale: 2
    t.boolean  "active",                                          default: true
    t.boolean  "push",                                            default: false, null: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "wishlists", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishlists", ["product_id"], name: "index_wishlists_on_product_id"
  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id"

end
