require 'rails_helper'


describe 'Usuário edita um fornecedor' do
    
    it 'a partir da página de detalhes' do
        #Arrange
        supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'2958274000113', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                     state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Flor de Lima')
        click_on('Editar')
        
        #Assert
        expect(page).to have_content('Editar Fornecedor')
        expect(page).to have_field('Razão Social', with: 'FLOR DE LIMA LTDA')
        expect(page).to have_field('Nome Fantasia', with: 'Flor de Lima')
        expect(page).to have_field('CNPJ', with: '2958274000113')
        expect(page).to have_field('Endereço', with: 'Avenida das Américas, 100')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('Estado', with:'RJ')
        expect(page).to have_field('E-mail', with: 'contato@flordelima.com.br')
        expect(page).to have_field('Telefone', with: '2198180045')
    end 

    it 'com sucesso' do
        
        #Arrange
         supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'2958274000113', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                         state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
         #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Flor de Lima')
        click_on('Editar')
        fill_in('Nome Fantasia', with: 'Flor de Lima Confeitaria')
        fill_in('Endereço', with: 'Avenida dos Papagaios, 500')
        fill_in('Telefone', with: '21971013006')
        click_on('Enviar')
        
            
        #Assert
        expect(page).to have_content('Fornecedor atualizado com sucesso')
        expect(page).to have_content('Flor de Lima Confeitaria')
        expect(page).to have_content('Endereço: Avenida dos Papagaios, 500')
        expect(page).to have_content('Telefone: 21971013006')
    end 
    
    it 'e mantém os campos obrigatórios' do
        #Arrange
        supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'2958274000113', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                    state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
    
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Flor de Lima')
        click_on('Editar')
        fill_in('Nome Fantasia', with: '')
        fill_in('Razão Social', with: '')
        fill_in('CNPJ', with: '')
        fill_in('E-mail', with: '')
        click_on('Enviar')
    
        #Assert
        expect(page).to have_content('Não foi possível atualizar o fornecedor')
        expect(page).to have_content('Nome Fantasia não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('CNPJ não possui o tamanho esperado (13 caracteres)')
        end 
end