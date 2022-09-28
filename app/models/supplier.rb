class Supplier < ApplicationRecord
    validates :brand_name, :corporate_name, :registration_number, :email,  presence: true
    validates :registration_number, length:  {is: 14 } 
    validates :registration_number, uniqueness: true
end