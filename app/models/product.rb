# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :categories

  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  composed_of :price,
              class_name: 'Money',
              mapping: %w[price cents],
              converter: proc { |value| Money.new(value) }

  def average_review
    if reviews.average(:rating).nil?
      'not reviewed yet!'
    else
      reviews.average(:rating)
    end
  end
end
