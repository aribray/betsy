require "test_helper"

describe Product do
  let(:product) { products(:turtleneck) }

  describe "validations" do
    it "requires a name" do
      product.name = nil

      valid_product = product.valid?

      expect(valid_product).must_equal false
      expect(product.errors.messages).must_include :name
      expect(product.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a unique name" do
      duplicate_product_name = Product.new(name: product.name)

      expect(duplicate_product_name.save).must_equal false
      expect(duplicate_product_name.errors.messages).must_include :name
      expect(duplicate_product_name.errors.messages[:name]).must_equal ["has already been taken"]
    end

    it "requires a price and a number" do
      product.price = nil

      valid_product = product.valid?

      expect(valid_product).must_equal false
      expect(product.errors.messages).must_include :price
      expect(product.errors.messages[:price]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a price greater than 0" do
      product.price = -1
      valid_product = product.valid?

      expect(valid_product).must_equal false
      expect(product.errors.messages).must_include :price
      expect(product.errors.messages[:price]).must_equal ["must be greater than 0"]
    end
  end

  describe "relationships" do
    let (:category) {
      Category.create(name: "Food")
    }
    let (:new_category) {
      Category.create(name: "Wellness")
    }

    let (:user) {
      users(:dee)
    }
    it "belongs to a user" do
      product.user = user

      expect(product.user_id).must_equal user.id
      expect(product).must_respond_to :user
    end

    it "has many and belongs to categories" do
      product.categories << category
      product.save

      new_product = Product.find_by(id: product.id)

      expect(new_product.categories).must_include category
      expect(new_product.categories.length).must_equal 1

      product.categories << new_category
      product.save

      another_product = Product.find_by(id: product.id)
      expect(another_product.categories).must_include new_category
      expect(another_product.categories.length).must_equal 2
    end

    it "can have many categories for 1 product" do
      product.categories << category
      product.save

      test_product = Product.find_by(id: product.id)

      expect(test_product.categories.length).must_equal 1

      product.categories << new_category
      product.save

      test_product = Product.find_by(id: product.id)
      expect(test_product.categories.length).must_equal 2
    end

    it "can have many products for 1 category" do
      product_two = products(:two)
      product_two.categories << category
      product_two.save

      product.categories << category
      product.save

      this_category = Category.find_by(id: category.id)

      expect(this_category.products).must_include product_two
      expect(this_category.products).must_include product
      expect(this_category.products.length).must_equal 2
    end

    it "has a list of order items" do
      product.must_respond_to :orderitems
      product.orderitems.each do |item|
        item.must_be_kind_of Orderitem
      end
    end

    it "has a list of reviews" do
      product.must_respond_to :reviews
      product.reviews.each do |item|
        item.must_be_kind_of Review
      end
    end

    it "can have 0 reviews" do
      excellent_product = Product.new(name: "excellent", price: 20)
      new_reviews = excellent_product.reviews

      expect(new_reviews.length).must_equal 0
    end

    it "when destroyed, will destroy order items" do
      new_order = orders(:one)
      new_order.orderitems << orderitems(:one)

      expect {
        product.destroy
      }.must_change "Orderitem.count", -1
      find_destroyed_product = Product.find_by(id: product.id)
      expect(find_destroyed_product).must_equal nil
    end

    it "when destroyed, will destroy the reviews" do
      new_review = reviews(:one)
      product.reviews << new_review

      expect {
        product.destroy
      }.must_change "Review.count", -1
      find_destroyed_product = Product.find_by(id: product.id)
      expect(find_destroyed_product).must_equal nil
    end
  end

  describe "average_review" do
    it "will return a message when a product doesn't have a review" do
      newer_product = Product.create(name: "newer_product", price: 200)
      expect(newer_product.average_review).must_equal "not reviewed yet!"
    end

    it "will return an average of ratings for a product" do
      new_review = Review.new(rating: 3)
      product.reviews << new_review

      expect(product.average_review).must_equal 3.5
    end
  end
end
