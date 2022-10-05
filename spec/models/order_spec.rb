require 'rails_helper'

RSpec.describe Order, type: :model do
    describe '#valid' do
        it 'deve ter um código' do
            #Arrange
            user = User.create!(name: 'Ana', email: 'ana@gmail.com', password: 'password')

            warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

            supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                 state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
    
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-01')
            #Act
            result = order.valid?
            #Assert
            expect(result).to be true 
        end 

        it 'data estimada de entrega deve ser obrigatória' do
            #Arrange

            order = Order.new(estimated_delivery_date:'')
            #Act
            order.valid?
            result = order.errors.include?(:estimated_delivery_date)
            #Assert
            expect(result).to be true 
        end 

        it 'data estimada de entrega não deve ser passada' do
            #Arrange
            order = Order.new(estimated_delivery_date: 1.day.ago)
            #Act
            order.valid?
            #Assert
            expect(order.errors.include?(:estimated_delivery_date)).to be true 
            expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
        end 

        it 'data estimada de entrega não deve ser igual a hoje' do
        #Arrange
        order = Order.new(estimated_delivery_date: Date.today)
        #Act
        order.valid?
        #Assert
        expect(order.errors.include?(:estimated_delivery_date)).to be true 
        expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
        end

        
        it 'data estimada de entrega deve ser igual ou maior do que amanhã' do
            #Arrange
            order = Order.new(estimated_delivery_date: 1.day.from_now)
            #Act
            order.valid?
            #Assert
            expect(order.errors.include?(:estimated_delivery_date)).to be false 
            end
    end

    describe 'gera um código aleatório' do
        it 'ao criar um novo pedido' do
            #Arrange 
            user = User.create!(name: 'Ana', email: 'ana@gmail.com', password: 'password')

            warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

            supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                     state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
        
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-01')
            
            #Act
            order.save!
            result = order.code 
            #Arrange
            expect(result).not_to be_empty
            expect(result.length).to eq 10 
        end

        it 'e o código é único' do
            #Arrange 
            user = User.create!(name: 'Ana', email: 'ana@gmail.com', password: 'password')

            warehouse = Warehouse.create!(name:'Rio', code:'SDU', city:'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

            supplier = Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                     state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
        
            first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-01')

            second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-15')

            #Act
            second_order.save!
            #Arrange
            expect(second_order.code).not_to eq first_order.code 
        end
    end 
end
