require 'rails_helper'

describe 'Usuário remove um galpão' do

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
        w = Warehouse.create!(name:'Cuiabá', code:'CWB', city:'Cuiabá', area: 100_000,
                              address: 'Avenida dos Jacarés, 1000', cep: '56000-000', description: 'Galpão no centro do país')

        #Act
        login_as(user)
        visit(root_path)
        click_on('Cuiabá')
        click_on('Remover')

        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content('Galpão removido com sucesso')
        expect(page).not_to have_content('Cuiaba')
        expect(page).not_to have_content('CWB')
    end 

    it 'não apague todos os galpões' do
        #Arrange
        user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
        first_warehouse = Warehouse.create!(name:'Cuiabá', code:'CWB', city:'Cuiabá', area: 100_000, address: 'Avenida dos Jacarés, 1000',
                                             cep: '56000-000', description: 'Galpão no centro do país')

        second_warehouse = Warehouse.create!(name:'Belo Horizonte', code:'BHZ', city:'Belo Horizonte', area: 200_000, address: 'Avenida Tiradentes, 1000', 
                                            cep: '46000-000', description: 'Galpão para cargas mineiras')

        #Act
        login_as(user)
        visit(root_path)
        click_on('Cuiabá')
        click_on('Remover')

        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content('Galpão removido com sucesso')
        expect(page).not_to have_content('Cuiaba')
        expect(page).not_to have_content('CWB')
        expect(page).to have_content('Belo Horizonte')
        expect(page).to have_content('BHZ')
    end 
end 