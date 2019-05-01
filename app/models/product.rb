# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :categories
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
