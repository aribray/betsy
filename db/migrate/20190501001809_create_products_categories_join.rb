class CreateProductsCategoriesJoin < ActiveRecord::Migration[5.2]
  def change
    create_table :products_categories_joins do |t|
      t.belongs_to :product, index: true
      t.belongs_to :category, index: true
    end
  end
end
