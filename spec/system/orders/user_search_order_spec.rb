require 'rails_helper'

describe 'Usuário busca por um pedido' do

    it 'e deve estar autenticado' do
        #Arrange
        user = User.create!(name: 'joao', email: 'joao@email.com', password: 'password')
        #Act
        login_as(user)
        visit(root_path)
        #Assert
        within('header nav') do 
            expect(page).to have_field('Buscar Pedido')
            expect(page).to have_button('Buscar')
        end 
    end 

    it 'e deve estar autenticado' do
        #Arrange
        user = User.create!(name: 'joao', email: 'joao@email.com', password: 'password')
        #Act
        visit(root_path)
        #Assert
        within('header nav') do 
            expect(page).not_to have_field('Buscar Pedido')
            expect(page).not_to have_button('Buscar')
        end 
    end 

    it 'e encontra um pedido' do
     #Arrange
     user = User.create!(name: 'joao', email: 'joao@email.com', password: 'password')


    warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                     state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
        
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
            
     #Act
     login_as(user)
     visit(root_path)
     fill_in('Buscar Pedido', with: order.code)
     click_on('Buscar')
     #Assert
     expect(page).to have_content("Resultados da Busca por: #{order.code}")
     expect(page).to have_content("1 pedido encontrado")
     expect(page).to have_content("Código: #{order.code}")
     expect(page).to have_content('Galpão Destino: SDU - Rio')
     expect(page).to have_content('Fornecedor: FLOR DE LIMA LTDA')
    end 

    it 'e encontra múltiplos pedidos' do
        #Arrange
        user = User.create!(name: 'joao', email: 'joao@email.com', password: 'password')
   
        first_warehouse = Warehouse.create!(name:'Aeroporto SP', code:'GRU', city:'São Paulo', area: 60_000, address: 'Avenida Ibirapuera, 20', cep: '50000-000', description: 'Galpão de São Paulo')
        second_warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
   
        supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                        state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
        
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU1234567')
        first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier,
                              estimated_delivery_date: 1.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU9449275')
        second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier,
                              estimated_delivery_date: 1.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU0000000')
        third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier,
                               estimated_delivery_date: 1.day.from_now)
               
        #Act
        login_as(user)
        visit(root_path)
        fill_in('Buscar Pedido', with: 'GRU')
        click_on('Buscar')
        #Assert
        expect(page).to have_content('2 pedidos encontrados')
        expect(page).to have_content('GRU1234567')
        expect(page).to have_content('GRU9449275')
        expect(page).not_to have_content('SDU0000000')
        expect(page).to have_content('Galpão Destino: GRU - Aeroporto SP')
        expect(page).not_to have_content('Galpão Destino: SDU - Rio')
       end 
end 