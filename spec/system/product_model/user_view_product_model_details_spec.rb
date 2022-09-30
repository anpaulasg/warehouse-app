require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
    it 'e vê informações adicionais' do
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

        #Assert
        expect(page).to have_content('Televisão')
        expect(page).to have_content('Fornecedor: Samsung')
        expect(page).to have_content('SKU: TV32-SAMSU-XPTO90 ')
        expect(page).to have_content('Dimensão: 45 cm x 70 cm x 10 cm')
        expect(page).to have_content('Peso: 8000g')
    end


    it 'e volta para a lista de fornecedores' do
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
        click_on('Voltar')

        #Assert
        expect(current_path).to eq (product_models_path)
    end 
end 
