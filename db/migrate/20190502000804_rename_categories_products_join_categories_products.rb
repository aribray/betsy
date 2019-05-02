class RenameCategoriesProductsJoinCategoriesProducts < ActiveRecord::Migration[5.2]
  def change
    rename_table :categories_products_joins, :categories_products
  end
end
