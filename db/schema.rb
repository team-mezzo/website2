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

ActiveRecord::Schema.define(version: 20141224165625) do

  create_table "donations", force: true do |t|
    t.datetime "pickup_start"
    t.datetime "pickup_end"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "donor_id"
    t.integer  "recipient_id"
  end

  create_table "food_portions", force: true do |t|
    t.integer  "raw_amount"
    t.integer  "processed_amount"
    t.text     "description"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "donation_id"
  end

  create_table "stakeholders", force: true do |t|
    t.string   "business_name"
    t.string   "manager_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "role"
  end

  add_index "stakeholders", ["email"], name: "index_stakeholders_on_email", unique: true

end
