require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(email: 'vinicius@email.com', password: 'password', name: 'Vinícius')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104', full_address: 'Torre da Indústria, 1',
                    city: 'Teresina', state: 'PI', email: 'vendor@spark.com')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Avenida do Atlântica, 80', cep: '80000-000', description: 'Perto do Aeroporto')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select 'ACME - ACME LTDA - 4344721600102', from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME - ACME LTDA - 4344721600102'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).to have_content 'Usuário Responsável: Vinícius - vinicius@email.com'
    expect(page).not_to have_content 'Galpão Maceio'
    expect(page).not_to have_content 'Spark Industries Brasil LTDA'
  end
end