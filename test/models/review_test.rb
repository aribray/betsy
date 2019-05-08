require "test_helper"

describe Review do
  let(:review) { reviews(:one) }

  describe "validations" do
    it "must have a rating" do
      review.rating = nil
      valid_review = review.valid?

      expect(valid_review).must_equal false
      expect(review.errors.messages).must_include :rating
      expect(review.errors.messages[:rating]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    let (:product) {
      products(:turtleneck)
    }

    it "belongs to product" do
      review.product = product

      expect(review.product_id).must_equal product.id
      expect(review).must_respond_to :product
    end

    it "will not change the product count when destroyed" do
      my_review = review

      expect {
        my_review.destroy
      }.wont_change "Product.count"
    end
  end
end
