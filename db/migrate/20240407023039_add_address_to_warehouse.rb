class AddAddressToWarehouse < ActiveRecord::Migration[7.1]
  def change
    add_column :warehouses, :address, :string
  end
end
