class RenameProductsCategoriesToCategoriesProducts < ActiveRecord::Migration[5.2]
  def change
    rename_table :products_categories_joins, :categories_products_joins
  end
end
