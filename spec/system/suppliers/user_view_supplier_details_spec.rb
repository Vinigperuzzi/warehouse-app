require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    expect(page).to have_content('ACME LTDA')
    expect(page).to have_content('Documento: 4344721600102')
    expect(page).to have_content('Endereço: Av das Palmas, 100')
    expect(page).to have_content('E-mail: contato@acme.com')
  end

  it 'e volta para a tela inicial' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344721600102', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
