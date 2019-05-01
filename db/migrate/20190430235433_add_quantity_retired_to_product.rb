class AddQuantityRetiredToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :quantity, :integer, :default => 0
    add_column :products, :retired, :boolean, :default => false
  end
end
