require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
    it 'a partir da tela inicial' do
        #Arrange
        
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Cadastrar Fornecedor')

        #Assert
        expect(page).to have_field('Nome Fantasia') 
        expect(page).to have_field('Razão Social')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')
        expect(page).to have_field('E-mail')
        expect(page).to have_field('Telefone')
    end 

    it 'com sucesso' do

        #Arrange
        
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Cadastrar Fornecedor')
        fill_in('Nome Fantasia', with: 'Flor de Lima')
        fill_in('Razão Social', with: 'FLOR DE LIMA LTDA')
        fill_in('CNPJ', with: '09582740001134')
        fill_in('Endereço', with: 'Avenida das Américas, 100')
        fill_in('Cidade', with: 'Rio de Janeiro')
        fill_in('Estado', with: 'RJ')
        fill_in('E-mail', with: 'contato@flordelima.com.br')
        fill_in('Telefone', with: '2198180045')
        click_on('Enviar')

        #Assert
        expect(page).to have_content('Fornecedor cadastrado com sucesso')
        expect(page).to have_content('FLOR DE LIMA LTDA')
        expect(page).to have_content('CNPJ: 09582740001134')
        expect(page).to have_content('E-mail: contato@flordelima.com.br')  
    end 

    it 'com dados incompletos' do 
        #Arrange

        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Cadastrar Fornecedor')
        fill_in('Nome Fantasia', with: '')
        fill_in('Razão Social', with: '')
        fill_in('CNPJ', with: '')
        fill_in('E-mail', with: '')
        click_on('Enviar')

        #Assert
        expect(page).to have_content('Fornecedor não cadastrado')
        expect(page).to have_content('Nome Fantasia não pode ficar em branco')
        expect(page).to have_content('Razão Social não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('E-mail não pode ficar em branco')
    end 
end 