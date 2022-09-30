require 'rails_helper'

describe 'Usuário edita dados de um modelo de produto' do
    
    it 'a partir da página de detalhes' do
        #Arrange
        user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
            city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')
        
        ProductModel.create!(name: 'Televisão', weight: 8000, width: 70, height: 45, depth: 10,
                             sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
        #Act
        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Televisão')
        click_on('Editar')
        
        #Assert
        expect(page).to have_content('Editar Modelo de Produto')
        expect(page).to have_field('Nome', with: 'Televisão')
        expect(page).to have_field('Peso', with: '8000')
        expect(page).to have_field('Altura', with: '45')
        expect(page).to have_field('Profundidade', with: '10')
        expect(page).to have_field('Largura', with: '70')
        expect(page).to have_field('SKU', with: 'TV32-SAMSU-XPTO90')
        expect(page).to have_select('Fornecedor', selected: 'Samsung')
    end 

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        ProductModel.create!(name: 'Televisão', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
        #Act
        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Televisão')
        click_on('Editar')
        fill_in('Nome', with: 'Televisão 50')
        fill_in('SKU', with: 'TV50-SAMSU-XPTO90')
        click_on('Enviar')
        #Assert
        expect(page).to have_content('Televisão 50')
        expect(page).to have_content('SKU: TV50-SAMSU-XPTO90')
    end 

    it ' e mantém campos obrigatórios' do
        #Arrange
        user = User.create!(name: 'Ana', email: 'ana@email.com', password:'password')
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        ProductModel.create!(name: 'Televisão', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        #Act
        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Televisão')
        click_on('Editar')
        fill_in('Nome', with: '')
        fill_in('SKU', with: '')
        click_on('Enviar')
        #Assert 
        expect(page).to have_content('Não foi possível atualizar o modelo de produto')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('SKU não pode ficar em branco')
    end
end 