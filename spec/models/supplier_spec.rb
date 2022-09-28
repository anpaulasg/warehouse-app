require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
        it 'false when brand name is empty' do
            #Arrange
            supplier = Supplier.create(corporate_name: 'FLOR DE LIMA LTDA', brand_name: '', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                       state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
            #Act
            result = supplier.valid? 

            #Assert
            expect(result). to eq false 
        end 

        it 'false when corporate name is empty' do
            #Arrange
            supplier = Supplier.create(corporate_name: '', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                     state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
            #Act
            result = supplier.valid? 

            #Assert
            expect(result). to eq false
        end

        it 'false when registration number is empty' do
          #Arrange
          supplier = Supplier.create(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                    state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
          #Act
          result = supplier.valid? 

          #Assert
          expect(result). to eq false
      end

      it 'false when email is empty' do
        #Arrange
        supplier = Supplier.create(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                  state:'RJ', email: '', telephone: '2198180045')
        #Act
        result = supplier.valid? 

        #Assert
        expect(result). to eq false

      
      end
    end 

    context 'use_already' do 
      it 'false when registration number is already in use' do 
        #Arrange
        first_supplier =  Supplier.create!(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'09582740001134', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                            state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')

        second_supplier = Supplier.create(corporate_name: 'ALCANTARA LTDA', brand_name: 'Alcantara Doces', registration_number:'09582740001134', full_address: 'Avenida da República, 200', city: 'Rio de Janeiro', 
                                          state:'RJ', email: 'contato@alcantara.com.br', telephone: '21971013006')
        #Act
        result = second_supplier.valid?
        #Assert 
        expect(result).to eq false
      end
    end 
    
    context 'registration_number lenght' do 
      it 'false when registration_number doesnt have sufficient characthers' do
        #Arrange
        supplier = Supplier.create(corporate_name: 'FLOR DE LIMA LTDA', brand_name: 'Flor de Lima', registration_number:'0958274000113', full_address: 'Avenida das Américas, 100', city: 'Rio de Janeiro', 
                                    state:'RJ', email: 'contato@flordelima.com.br', telephone: '2198180045')
        #Act
        result = supplier.valid?
        #Assert
        expect(result). to eq false
      end 
    end 
  end 
end 