require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
    
    it 'com sucesso' do
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
            city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')
        
        other_supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil', registration_number:'04589710000222', full_address: 'Avenida Ibirapuera, 300', 
                                          city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br', telephone: '21971013006')
        #Act
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar Novo')
        fill_in('Nome', with: 'TV 40 polegadas')
        fill_in('Peso', with: '10000')
        fill_in('Altura', with: '60')
        fill_in('Largura', with: '90')
        fill_in('Profundidade', with: '10')
        fill_in('SKU', with: 'TV40-SAMS-XPTO')
        select('LG', from: 'Fornecedor')
        click_on('Enviar')

        #Assert
        expect(page).to have_content('Modelo de Produto cadastrado com sucesso')
        expect(page).to have_content('TV 40 polegadas')
        expect(page).to have_content('Fornecedor: LG')
        expect(page).to have_content('SKU: TV40-SAMS-XPTO')
        expect(page).to have_content('Dimensão: 60 cm x 90 cm x 10 cm')
        expect(page).to have_content('Peso: 10000g')
    end 

    it 'e deve preencher todos os campos' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
            city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')
         
        #Act
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar Novo')
        fill_in('Nome', with: '')
        fill_in('SKU', with: '')
        click_on('Enviar')
        
        #Assert
        expect(page).to have_content('Não foi possível cadastrar o modelo de produto')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('SKU não pode ficar em branco')
    
    end 

end 