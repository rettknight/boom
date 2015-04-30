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

ActiveRecord::Schema.define(version: 20150430015243) do

  create_table "details", force: :cascade do |t|
    t.string  "key",        limit: 100
    t.string  "article",    limit: 100, null: false
    t.string  "amount",     limit: 100, null: false
    t.string  "lot",        limit: 100, null: false
    t.integer "product_id", limit: 4,   null: false
  end

  add_index "details", ["product_id"], name: "fk_Detail_Product1_idx", using: :btree

  create_table "envios", force: :cascade do |t|
    t.integer  "status",       limit: 4,   null: false
    t.datetime "date",                     null: false
    t.string   "reference",    limit: 100, null: false
    t.string   "origin",       limit: 100, null: false
    t.string   "destiny",      limit: 100, null: false
    t.string   "department",   limit: 100, null: false
    t.string   "comments",     limit: 255, null: false
    t.integer  "user_id",      limit: 4,   null: false
    t.integer  "transport_id", limit: 4
    t.integer  "detail_id",    limit: 4
  end

  add_index "envios", ["detail_id"], name: "fk_Envio_Details1_idx", using: :btree
  add_index "envios", ["transport_id"], name: "fk_Envio_Transport1_idx", using: :btree
  add_index "envios", ["user_id"], name: "fk_Envio_User1_idx", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "keyProduct", limit: 100
    t.text     "name",       limit: 255, null: false
    t.integer  "volume",     limit: 4,   null: false
    t.string   "unit",       limit: 100, null: false
    t.datetime "createdAt",              null: false
    t.datetime "updatedAt",              null: false
  end

  create_table "transports", force: :cascade do |t|
    t.string "name", limit: 100, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",               limit: 100,                 null: false
    t.string   "lastname",           limit: 100
    t.string   "email",              limit: 100,                 null: false
    t.string   "encrypted_password", limit: 255,                 null: false
    t.string   "salt",               limit: 200
    t.datetime "updatedAt",                                      null: false
    t.datetime "createdAt",                                      null: false
    t.datetime "deletedAt"
    t.datetime "lastConnection",                                 null: false
    t.string   "rfc",                limit: 255
    t.string   "curp",               limit: 255
    t.string   "avatar",             limit: 255
    t.boolean  "admin",              limit: 1,   default: false
  end

end
