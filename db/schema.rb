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

ActiveRecord::Schema[7.1].define(version: 2024_04_16_162127) do
  create_table "order_items", force: :cascade do |t|
    t.integer "product_model_id", null: false
    t.integer "order_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_model_id"], name: "index_order_items_on_product_model_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "warehouse_id", null: false
    t.integer "supplier_id", null: false
    t.integer "user_id", null: false
    t.date "estimated_delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.integer "status", default: 0
    t.index ["supplier_id"], name: "index_orders_on_supplier_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["warehouse_id"], name: "index_orders_on_warehouse_id"
  end

  create_table "product_models", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.string "sku"
    t.integer "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_product_models_on_supplier_id"
  end

  create_table "stock_product_destinations", force: :cascade do |t|
    t.integer "stock_product_id", null: false
    t.string "address"
    t.string "recipent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_product_id"], name: "index_stock_product_destinations_on_stock_product_id"
  end

  create_table "stock_products", force: :cascade do |t|
    t.integer "warehouse_id", null: false
    t.integer "order_id", null: false
    t.integer "product_model_id", null: false
    t.string "serial_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_stock_products_on_order_id"
    t.index ["product_model_id"], name: "index_stock_products_on_product_model_id"
    t.index ["warehouse_id"], name: "index_stock_products_on_warehouse_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "full_address"
    t.string "city"
    t.string "state"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "city"
    t.integer "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "cep"
    t.string "description"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_models"
  add_foreign_key "orders", "suppliers"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "warehouses"
  add_foreign_key "product_models", "suppliers"
  add_foreign_key "stock_product_destinations", "stock_products"
  add_foreign_key "stock_products", "orders"
  add_foreign_key "stock_products", "product_models"
  add_foreign_key "stock_products", "warehouses"
end
