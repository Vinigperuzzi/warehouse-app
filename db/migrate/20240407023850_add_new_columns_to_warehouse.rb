class AddNewColumnsToWarehouse < ActiveRecord::Migration[7.1]
  def change
    add_column :warehouses, :cep, :string
    add_column :warehouses, :description, :string
  end
end
