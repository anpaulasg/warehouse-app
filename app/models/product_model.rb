class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :width, :height, :depth, :sku, :supplier, presence: true 
  validates :sku, uniqueness: true 
  validates :width, :height, :depth, :weight, comparison: { greater_than: 0}
end
