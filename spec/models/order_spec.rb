require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      user = User.create!(email: 'vinicius@email.com', password: 'password', name: 'Vinícius')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      result = order.valid?

      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: nil)

      result = order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("não pode ficar em branco")
    end

    it 'data estimada de entrega não deve ser passada' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      result = order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
    end

    it 'data estimada de entrega não deve ser igual a hoje' do
      order = Order.new(estimated_delivery_date: Date.today)

      result = order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
    end

    it 'data estimada de entrega deve ser futura' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      result = order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      expect(result).to be false
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      user = User.create!(email: 'vinicius@email.com', password: 'password', name: 'Vinícius')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      order.save!
      result = order.code
      
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é único' do
      warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      user = User.create!(email: 'vinicius@email.com', password: 'password', name: 'Vinícius')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      second_order.save!
      
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
