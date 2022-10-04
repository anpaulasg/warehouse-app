require 'rails_helper'

describe 'Usuário cadastra um pedido' do

    it 'e deve estar autenticado'do
        #Arrange

        #Act
        visit(root_path)
        click_on('Registrar Pedido')
        #Assert
        expect(current_path).to eq new_user_session_path
    end 
    it 'com sucesso' do 
        #Arrange
        user = User.create!(name: 'Ana', email: 'ana@gmail.com', password: 'password')

        warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        Warehouse.create!(name:'Maceió', code:'MCZ', city:'Maceio', area: 50_000, address: 'Avenida Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')

        supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                     state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')

        Supplier.create!(corporate_name: 'NESTLE LTDA', brand_name: 'Nestlé', registration_number:'03583740505136', full_address: 'Avenida Ibirapuera, 20', city: 'São Paulo', 
                         state:'SP', email: 'contato@nestle.com.br', telephone: '1125584766')
        
        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')

        #Act
        login_as(user)
        visit(root_path)
        click_on('Registrar Pedido')
        select('SDU - Rio', from: 'Galpão Destino')
        select(supplier.corporate_name, from: 'Fornecedor')
        fill_in('Data Prevista de Entrega', with: '20/12/2022')
        click_on('Gravar')
        #Assert
        expect(page).to have_content('Pedido registrado com sucesso')
        expect(page).to have_content('Pedido ABC1234567')
        expect(page).to have_content('Galpão Destino: SDU - Rio')
        expect(page).to have_content('Fornecedor: FLOR DE LIMA LTDA')
        expect(page).to have_content('Usuário Responsável: Ana - ana@gmail.com')
        expect(page).to have_content('Data Prevista de Entrega: 20/12/2022')
        expect(page).not_to have_content('Fornecedor: Nestlé')
        expect(page).not_to have_content('Maceió')
    end 
end