# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :product

  validates :rating, presence: true
end
