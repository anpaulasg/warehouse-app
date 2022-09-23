require 'rails_helper'

describe 'Usuário vê lista de fornecedores' do
    
    it 'a partir da tela menu' do
        #Arrange

        #Act
        visit(root_path)
        within('nav') do
            click_on('Fornecedores')
        end 
        #Assert
        expect(current_path).to eq suppliers_path
    end 

    it 'com sucesso' do
        #Arrange
        Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'02958274000113', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                            state:'RJ', email: 'contato@flordelima.com.br')

        #Act
        visit(root_path)
        within('nav') do
            click_on('Fornecedores')
        end 

        #Assert
        expect(page).to have_content('Fornecedores')
        expect(page).to have_content('Flor de Lima')
        expect(page).to have_content('Rio de Janeiro - RJ')
    end 

    it 'não tem fornecedores cadastrados' do 
        #Arrange

        #Act
        visit(root_path)
        click_on('Fornecedores')
        expect(page).to have_content('Não existem fornecedores cadastrados.')

        #Assert
    end 

end 