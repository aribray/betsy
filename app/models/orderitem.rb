# frozen_string_literal: true

class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # validate that is has order and product, or unique index in database
  validates :quantity, numericality: {greater_than: 0}

  TAX = 0.101

  def item_total
    return self.quantity * self.product.price
  end

end
