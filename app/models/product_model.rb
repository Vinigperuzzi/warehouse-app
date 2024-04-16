class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  validates :name, :weight, :height, :width, :depth, :sku, :supplier, presence: true
end
