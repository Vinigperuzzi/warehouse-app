require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
    user = User.create!(name: 'Vinícius', email: 'vinicius@email.com', password: 'password')
    user2 = User.create!(name: 'Débora', email: 'debora@email.com', password: 'password2')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user2)
    patch(order_path(order.id), params: {order: {supplier_id: 3 }})

    expect(response).to redirect_to(root_path)
  end
end