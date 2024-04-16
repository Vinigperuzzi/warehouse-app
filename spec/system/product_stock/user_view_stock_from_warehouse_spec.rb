require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    user = User.create!(name: 'Vinícius', email: 'vini@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                            registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                            city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.week.from_now)
    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
                                      sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
    product_soundbar = ProductModel.create!(name: 'SoundBar 7.1', weight: 3000, width: 80, height: 15, depth: 20, 
                                            sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)
    product_notebook = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 2000, width: 40, height: 9, depth: 20, 
                                            sku: 'NOTEI5-SAMSU-TLI99', supplier: supplier)

    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_notebook) }

    login_as user
    visit root_path
    click_on 'Aeroporto SP'

    within("section#stock_products") do
      expect(page).to have_content 'Itens em Estoque'
      expect(page).to have_content '3 x TV32-SAMSU-XPTO90'
      expect(page).to have_content '2 x NOTEI5-SAMSU-TLI99'
      expect(page).not_to have_content 'SOU71-SAMSU-NOIZ77'
    end
  end

  it 'e dá baixa em um item' do
    user = User.create!(name: 'Vinícius', email: 'vini@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                            registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000',
                            city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.week.from_now)
    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
    sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv) }

    login_as user
    visit root_path
    click_on 'Aeroporto SP'
    select 'TV32-SAMSU-XPTO90', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada'

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso.'
    expect(page).to have_content '1 x TV32-SAMSU-XPTO90'
  end
end