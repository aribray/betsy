class Order < ApplicationRecord
  has_many :orderitems, dependent: :destroy
end
