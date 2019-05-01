class AddQuantityAndShippedToOrderitems < ActiveRecord::Migration[5.2]
  def change
    add_column :orderitems, :quantity, :integer, :default => 0
    add_column :orderitems, :shipped, :boolean, :default => false
  end
end
