class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order
end
