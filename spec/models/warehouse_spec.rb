require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
        # Assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when code is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: '', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
        # Assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when address is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: '', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
        # Assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when cep is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '', city: 'Rio', area: 1000, description: 'Alguma descrição')
        # Assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when city is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: '', area: 1000, description: 'Alguma descrição')
        # Assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when area is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: nil, description: 'Alguma descrição')
        # Assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when description is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: '')
        # Assert
        expect(warehouse.valid?).to eq false
      end
    end
    context 'code length' do
      it 'false when code length is different from 3 - Minor' do
        # Arrange
        w = Warehouse.new(name: 'Rio de Janeiro', code: 'RI', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
        # Assert
        expect(w.valid?).to eq false
      end
      it 'false when code length is different from 3 - Bigger' do
        # Arrange
        w = Warehouse.new(name: 'Rio de Janeiro', code: 'RIOS', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
        # Assert
        expect(w.valid?).to eq false
      end
    end
    it 'false when code is already in use' do
      # Arrange
      w1 = Warehouse.create(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      w2 = Warehouse.new(name: 'São Paulo', code: 'RIO', address: 'Address', cep: '11111-111', city: 'São Paulo', area: 5000, description: 'Uma descrição diferente')
      # Assert
      expect(w2.valid?).to eq false
    end
  end
end
