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
    before do
      @product = Product.create(name: "amazing product", user: user, price: 10)
      @new_product = Product.create(name: "new amazing product", user: user, price: 10)
    end
    it "has many products" do
      category.products << @product
      category.save

      new_category = Category.find_by(id: category.id)

      expect(new_category.products).must_include @product
      expect(new_category.products.length).must_equal 1

      category.products << @new_product
      category.save

      another_category = Category.find_by(id: category.id)
      expect(another_category.products).must_include @new_product
      expect(another_category.products.length).must_equal 2
    end

    it "can belong to many products" do
      category_two = categories(:two)
      category_two.products << @product
      category_two.save

      category.products << @product
      category.save

      product = Product.find_by(id: @product.id)
      expect(@product.categories).must_include category_two
      expect(@product.categories).must_include category
    end
  end
  #     it "can have 0 categories" do
  #       categories = product.categories

  #       expect(categories.length).must_equal 0
  #     end

  #     it "can have 1 or more categories by shoveling a category into product.categories" do
  #       new_category = categories(:one)

  #       product.categories << new_category

  #       expect(new_category.products).must_include product
  #     end
  #   end
end
# it "is valid when all required fields are present" do
#   category = categories(:fun)
#   valid_category = category.valid?
#   expect(valid_category).must_equal true
# end

# it "must be invalid if name is missing" do
#   new_category = Category.new(name: "FunFunFun")
#   valid_category = new_category.valid?
#   expect(new_category).must_equal false
# end
