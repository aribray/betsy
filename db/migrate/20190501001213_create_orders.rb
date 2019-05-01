class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :email
      t.string :address
      t.string :cc_name
      t.integer :cc_number
      t.integer :cvv
      t.integer :zipcode

      t.timestamps
    end
  end
end
