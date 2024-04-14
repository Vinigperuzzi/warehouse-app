require 'rails_helper'

describe 'usuário vê seus próprios pedidos' do
  it 'e deve deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    user1 = User.create!(name: 'Vinícius', email: 'vinicius@email.com', password: 'password')
    user2 = User.create!(name: 'Débora', email: 'debora@email.com', password: 'password2')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                description: 'Galpão destinado para cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000,
                                  address: 'Avenida do Porto, 80', cep: '25000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    first_order = Order.create!(user: user1, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: user2, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    third_order = Order.create!(user: user1, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content first_order.code
    expect(page).to have_content third_order.code
    expect(page).not_to have_content second_order.code
  end
end