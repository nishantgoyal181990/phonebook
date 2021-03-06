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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130214111854) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "password_confirmation"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "accounts", ["remember_token"], :name => "index_accounts_on_remember_token"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.integer  "pin_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "phone_number_home"
    t.integer  "phone_number_office"
    t.string   "email"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
