class AddCcExpirationToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :cc_expiration, :integer
  end
end
