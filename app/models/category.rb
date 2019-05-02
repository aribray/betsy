class Category < ApplicationRecord
  has_and_belongs_to_many :products
  # has_many :category_products
  # has_many :products, through: :category

  validates :name, presence: true, uniqueness: true
end
