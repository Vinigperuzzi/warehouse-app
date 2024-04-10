require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                  registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, 
                              sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end
    it 'weight is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                  registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      pm = ProductModel.new(name: 'TV 32', weight: nil, width: 70, height: 45, depth: 10, 
                              sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end
    it 'width is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                  registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      pm = ProductModel.new(name: 'TV 32', weight: 8000, width: nil, height: 45, depth: 10, 
                              sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end
    it 'height is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                  registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: nil, depth: 10, 
                              sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end
    it 'depth is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                  registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: nil, 
                              sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end
    it 'sku is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                  registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
                              sku: '', supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end
    it 'supplier is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                  registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
                              sku: 'TV32-SAMSU-XPTO90', supplier: nil)

      result = pm.valid?

      expect(result).to eq false
    end
  end
end
