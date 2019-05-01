class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :photo_url
      t.string :description
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
