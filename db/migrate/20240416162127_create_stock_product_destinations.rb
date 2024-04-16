class CreateStockProductDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_product_destinations do |t|
      t.references :stock_product, null: false, foreign_key: true
      t.string :address
      t.string :recipent

      t.timestamps
    end
  end
end
