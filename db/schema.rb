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

ActiveRecord::Schema.define(version: 20150429203930) do

  create_table "details", primary_key: "idDetail", force: :cascade do |t|
    t.string  "key",       limit: 100
    t.string  "article",   limit: 100, null: false
    t.string  "amount",    limit: 100, null: false
    t.string  "lot",       limit: 100, null: false
    t.integer "idProduct", limit: 4,   null: false
  end

  add_index "details", ["idProduct"], name: "fk_Detail_Product1_idx", using: :btree

  create_table "envios", primary_key: "idEnvio", force: :cascade do |t|
    t.integer  "status",      limit: 4,   null: false
    t.datetime "date",                    null: false
    t.string   "reference",   limit: 100, null: false
    t.string   "origin",      limit: 100, null: false
    t.string   "destiny",     limit: 100, null: false
    t.string   "department",  limit: 100, null: false
    t.string   "comments",    limit: 255, null: false
    t.integer  "idUser",      limit: 4,   null: false
    t.integer  "idTransport", limit: 4,   null: false
    t.integer  "idDetail",    limit: 4,   null: false
  end

  add_index "envios", ["idDetail"], name: "fk_Envio_Details1_idx", using: :btree
  add_index "envios", ["idTransport"], name: "fk_Envio_Transport1_idx", using: :btree
  add_index "envios", ["idUser"], name: "fk_Envio_User1_idx", using: :btree

  create_table "products", primary_key: "idProduct", force: :cascade do |t|
    t.string   "keyProduct", limit: 100
    t.text     "name",       limit: 255, null: false
    t.integer  "volume",     limit: 4,   null: false
    t.string   "unit",       limit: 100, null: false
    t.datetime "createdAt",              null: false
    t.datetime "updatedAt",              null: false
  end

  create_table "transports", primary_key: "idTransport", force: :cascade do |t|
    t.string "name", limit: 100, null: false
  end

  create_table "users", primary_key: "idUser", force: :cascade do |t|
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

  add_foreign_key "details", "products", column: "idProduct", primary_key: "idProduct", name: "fk_Detail_Product1"
  add_foreign_key "envios", "details", column: "idDetail", primary_key: "idDetail", name: "fk_Envio_Details1"
  add_foreign_key "envios", "transports", column: "idTransport", primary_key: "idTransport", name: "fk_Envio_Transport1"
  add_foreign_key "envios", "users", column: "idUser", primary_key: "idUser", name: "fk_Envio_User1"
end
