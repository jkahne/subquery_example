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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_line_items", force: :cascade do |t|
    t.integer "amount_cents"
    t.integer "vendor_invoice_id"
    t.index ["id"], name: "bill_line_items_id_uindex", unique: true, using: :btree
  end

  create_table "vendor_invoices", force: :cascade do |t|
    t.date "due_date"
    t.text "name"
    t.index ["id"], name: "vendor_invoices_id_uindex", unique: true, using: :btree
  end

  create_table "vendor_payments", force: :cascade do |t|
    t.integer "amount_cents"
    t.integer "vendor_invoice_id"
    t.index ["id"], name: "vendor_payments_id_uindex", unique: true, using: :btree
  end

  add_foreign_key "bill_line_items", "vendor_invoices", name: "bill_line_items_vendor_invoices_id_fk"
  add_foreign_key "vendor_payments", "vendor_invoices", name: "vendor_invoices__fk"
end
