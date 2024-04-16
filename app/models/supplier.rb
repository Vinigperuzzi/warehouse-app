class Supplier < ApplicationRecord
  has_many :product_models
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true  

  def full_description
    "#{brand_name} - #{corporate_name} - #{registration_number}"
  end
end
