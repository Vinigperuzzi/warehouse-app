class CreateStockProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_products do |t|
      t.references :warehouse, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.references :product_model, null: false, foreign_key: true
      t.string :serial_number

      t.timestamps
    end
  end
end
