class Order < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  has_many :products, through: :orderitems

  TAX = 0.101

  def subtotal
    return self.orderitems.sum { |items| items.item_total }
  end

  def taxes
    return self.subtotal * TAX
  end

  def total
    return self.subtotal * (1 + TAX)
  end
end
