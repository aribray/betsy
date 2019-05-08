# frozen_string_literal: true

require "test_helper"
require "pry"

describe ReviewsController do
  describe "create" do
    describe "guest users" do
      it "can create a new review" do
        product = products(:turtleneck)
        review_hash = {
          rating: 4,
          description: "This is great!",
        }
        expect do
          post product_reviews_path(product.id), params: review_hash
        end.must_change "Review.count", 1
      end

      it "will give bad request response if there are any errors" do
        product = products(:turtleneck)
        review_hash = {
          rating: nil,
          description: "Just okay.",
        }

        expect do
          post product_reviews_path(product.id), params: review_hash
        end.wont_change "Review.count"

        must_respond_with :ok
        expect(flash[:error]).must_equal "Save was unsuccessful. Try again!"
      end
    end # end of logged in users block

    describe "logged in users" do
      it "cannot leave a review for their own products" do
        product = products(:turtleneck)
        perform_login
        review_hash = {
          rating: 4,
          description: "This is great!",
        }

        expect do
          post product_reviews_path(product.id), params: review_hash
        end.wont_change "Review.count"

        expect(flash[:error]).must_equal "You cannot review your own products!"
      end

      it "can leave a review for a product that is not theirs" do
        perform_login
        product = products(:two)
        review_hash = {
          rating: 4,
          description: "This is great!",
        }
        expect do
          post product_reviews_path(product.id), params: review_hash
        end.must_change "Review.count", 1
      end
    end
  end
end
