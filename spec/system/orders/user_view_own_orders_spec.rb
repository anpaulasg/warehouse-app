require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
    it 'e deve estar autenticado' do
        #Arrange

        #Act
        visit(root_path)
        click_on('Meus Pedidos')

        #Assert
        expect(current_path).to eq(new_user_session_path)
    end 

    it 'e não vê outros pedidos' do
        #Arrange
         joao = User.create!(name: 'joao', email: 'joao@email.com', password: 'password')
         carla = User.create!(name: 'carla', email: 'carla@email.com', password: 'password')
   
        warehouse = Warehouse.create!(name:'Aeroporto SP', code:'GRU', city:'São Paulo', area: 60_000, address: 'Avenida Ibirapuera, 20', cep: '50000-000', description: 'Galpão de São Paulo')
        
        supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                        state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
                 
        first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier,
                                    estimated_delivery_date: 1.day.from_now)                             
        second_order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier,
                                     estimated_delivery_date: 1.day.from_now)
        third_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier,
                                    estimated_delivery_date: 1.week.from_now)
        #Act
        login_as(joao)
        visit(root_path)
        click_on('Meus Pedidos')
        #Assert
        expect(page).to have_content(first_order.code)
        expect(page).not_to have_content(second_order.code)
        expect(page).to have_content(third_order.code)
    end 
end 