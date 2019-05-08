class Category < ApplicationRecord
  has_and_belongs_to_many :products

  # attr_accessor :skip_name_validation
  validates :name, presence: true, uniqueness: true
  # , unless: :skip_name_validation
  
end
