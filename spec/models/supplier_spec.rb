require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate_name is empty' do
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        expect(supplier.valid?).to eq false
      end
      it 'false when brand_name is empty' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number: '4344721600102', full_address: '',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        expect(supplier.valid?).to eq false
      end
      it 'false when registration_number is empty' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        expect(supplier.valid?).to eq false
      end
      it 'false when full_address is empty' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: '',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        expect(supplier.valid?).to eq false
      end
      it 'false when city is empty' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                  city: '', state: 'SP', email: 'contato@acme.com')
        expect(supplier.valid?).to eq false
      end
      it 'false when state is empty' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: '', email: 'contato@acme.com')
        expect(supplier.valid?).to eq false
      end
      it 'false when email is empty' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: '')
        expect(supplier.valid?).to eq false
      end
    end
  end
end
