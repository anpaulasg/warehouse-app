require 'rails_helper'

describe 'Usuário edita um galpão' do
    
    it 'a partir da página de detalhes' do
        #Arrange
        user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
        warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000,
                                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        #Act
        login_as(user)
        visit(root_path)
        click_on('Rio')
        click_on('Editar')
        
        #Assert
        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Nome', with: 'Rio')
        expect(page).to have_field('Descrição', with: 'Galpão do Rio')
        expect(page).to have_field('Código', with: 'SDU')
        expect(page).to have_field('Endereço', with: 'Avenida do Porto, 1000')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('CEP', with:'20000-000')
        expect(page).to have_field('Área', with: '60000')
    end 

    it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
    warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000,
                                 address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
    
    #Act
    login_as(user)
    visit(root_path)
    click_on('Rio')
    click_on('Editar')
    fill_in('Nome', with: 'Galpão Internacional')
    fill_in('Área', with: '200000')
    fill_in('Endereço', with: 'Avenida dos Galpões, 500')
    click_on('Enviar')
    
    #Assert
    expect(page).to have_content('Galpão atualizado com sucesso')
    expect(page).to have_content('Nome: Galpão Internacional')
    expect(page).to have_content('Endereço: Avenida dos Galpões, 500')
    expect(page).to have_content('Área: 200000 m2')
    end 

    it 'e mantém os campos obrigatórios' do
    #Arrange
    user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
    warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    #Act
    login_as(user)
    visit(root_path)
    click_on('Rio')
    click_on('Editar')
    fill_in('Nome', with: '')
    fill_in('Área', with: '')
    fill_in('Endereço', with: 'Avenida dos Galpões, 500')
    click_on('Enviar')

    #Assert
    expect(page).to have_content('Não foi possível atualizar o galpão.')
    end 
end