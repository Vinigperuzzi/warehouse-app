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
    fill_in 'Data Prevista de Entrega', with: 1.day.from_now
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME - ACME LTDA - 4344721600102'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
    expect(page).to have_content 'Usuário Responsável: Vinícius - vinicius@email.com'
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page).not_to have_content 'Galpão Maceio'
    expect(page).not_to have_content 'Spark Industries Brasil LTDA'
  end

  it 'e não informa a data de entrega' do
    warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
    user = User.create!(email: 'vinicius@email.com', password: 'password', name: 'Vinícius')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'RIO - Rio de Janeiro', from: 'Galpão Destino'
    select 'ACME - ACME LTDA - 4344721600102', from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível registrar o pedido.'
    expect(page).to have_content 'Data Prevista de Entrega não pode ficar em branco'
  end
end