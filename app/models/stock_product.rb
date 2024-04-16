class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model

  before_validation :generate_serial_number, on: :create

  private

  def generate_serial_number
    self.serial_number = SecureRandom.alphanumeric(20).upcase
  end
end
