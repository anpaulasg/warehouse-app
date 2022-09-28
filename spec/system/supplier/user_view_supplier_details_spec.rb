require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor ' do
    it 'a partir da tela inicial' do
        #Arrange
        
        Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
            state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')

        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Flor de Lima')

        #Assert
        expect(page).to have_content('FLOR DE LIMA LTDA')
        expect(page).to have_content('Documento: 09582740001134')
        expect(page).to have_content('Endereço: Avenida das Américas, 100, Rio de Janeiro - RJ')
        expect(page).to have_content('E-mail: contato@flordelima.com.br')
        expect(page).to have_content('Telefone: 2198180045')

    end 

    it 'e volta para a lista/tela inicial de fornecedores' do 

        #Arrange
        Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                         state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Flor de Lima')
        click_on('Voltar')
        #Assert
        expect(current_path).to eq suppliers_path
    end 
end 