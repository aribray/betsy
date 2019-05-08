require "test_helper"

describe Category do
  let (:category) {
    categories(:fun)
  }
  let (:user) {
    users(:dee)
  }

  describe "validations" do
    it "requires a name" do
      category.name = nil

      valid_category = category.valid?

      expect(valid_category).must_equal false
      expect(category.errors.messages).must_include :name
      expect(category.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have an unique name" do
      duplicate_category = Category.new(name: category.name)

      expect(duplicate_category.save).must_equal false
      expect(duplicate_category.errors.messages).must_include :name
      expect(duplicate_category.errors.messages[:name]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    let (:product) {
      Product.create(name: "amazing product", user: user, price: 10)
    }
    let (:new_product) {
      Product.create(name: "new amazing product", user: user, price: 10)
    }

    it "has many and belongs to products" do
      category.products << product
      category.save

      new_category = Category.find_by(id: category.id)

      expect(new_category.products).must_include product
      expect(new_category.products.length).must_equal 1

      category.products << new_product
      category.save

      another_category = Category.find_by(id: category.id)
      expect(another_category.products).must_include new_product
      expect(another_category.products.length).must_equal 2
    end

    it "can have many products for 1 category" do
      category.products << product
      category.save

      test_category = Category.find_by(id: category.id)

      expect(test_category.products.length).must_equal 1

      category.products << new_product
      category.save

      test_category = Category.find_by(id: category.id)

      expect(test_category.products.length).must_equal 2
    end

    it "can have many categories for 1 product" do
      category_two = categories(:two)
      category_two.products << product
      category_two.save

      category.products << product
      category.save

      this_product = Product.find_by(id: product.id)

      expect(this_product.categories).must_include category_two
      expect(this_product.categories).must_include category
      expect(this_product.categories.length).must_equal 2
    end

    it "can have 0 categories" do
      categories = product.categories

      expect(categories.length).must_equal 0
    end
  end
end
