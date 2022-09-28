require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'name is mandatory' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: '', weight: 8000, width: 70, height: 45, depth: 10,
                                  sku: 'TV32-SAMSU-XPTO90', supplier:supplier)
        #Act 
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end 

      it 'sku is mandatory' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: 10,
                                  sku: '', supplier:supplier)
        #Act 
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end 

      it 'weight is mandatory' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: 'TV 40 polegadas', weight: nil, width: 70 , height: 45, depth: 10,
                                  sku: 'TV40-SAMSU-XPTO90', supplier: supplier)
        #Act 
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end 

      it 'width is mandatory' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: 'TV 40 polegadas', weight: 8000, width: nil, height: 45, depth: 10,
                                  sku: 'TV40-SAMSU-XPTO90', supplier: supplier)
        #Act 
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end 

      it 'height is mandatory' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: 'TV 40 polegadas', weight: 8000, width: 70, height: nil, depth: 10,
                                  sku: 'TV40-SAMSU-XPTO90', supplier: supplier)
        #Act 
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end 

      it 'depth is mandatory' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: nil,
                                  sku: 'TV40-SAMSU-XPTO90', supplier: supplier)
        #Act 
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end 

      it 'supplier is mandatory' do 
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: 10,
                                  sku: 'TV40-SAMSU-XPTO90', supplier: nil)
        #Act 
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end 
    end 
    context 'uniqueness' do 
      it 'sku is unique' do
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        first_product = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                              sku: 'TV32-SAMSU-XPTO90', supplier:supplier)

        second_product = ProductModel.create(name: 'Soundbar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20,
                                              sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
        
        #Act 
        result = second_product.valid?

        #Assert
        expect(result).to eq false
      end 
    end
    context 'dimension and weight values' do
      it 'dimension must be greater than zero' do
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')

        pm = ProductModel.create(name: 'TV 32', weight: 8000, width: 0, height: -1, depth: 0,
                                  sku: 'TV32-SAMSU-XPTO90', supplier:supplier)

        #Act
        result = pm.valid?
        #Assert
        expect(result). to eq false 
      end  

      it 'weight must be greater than zero' do
        #Arrange
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'07317108000151', full_address: 'Avenida das Nações Unidas, 1000', 
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br', telephone: '2198180045')
  
        pm = ProductModel.create(name: 'TV 32', weight: 0, width: 80, height: 15, depth: 20,
                                    sku: 'TV32-SAMSU-XPTO90', supplier:supplier)
  
        #Act
        result = pm.valid?
        #Assert
        expect(result). to eq false 
      end 
    end 
  end 
end
