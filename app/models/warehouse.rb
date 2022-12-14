class Warehouse < ApplicationRecord
    validates :name, :code, :city, :description, :address, :cep, :area, presence: true
    validates :cep, length:  {is: 9 } 
    validates :code, :name, uniqueness: true 

    def full_description
        "#{code} - #{name}"
    end 

end
