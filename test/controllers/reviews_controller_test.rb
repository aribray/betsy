# frozen_string_literal: true

require 'test_helper'
require 'pry'

describe ReviewsController do
  describe 'new' do
    it 'should get new' do
      get new_review_path
      value(response).must_be :success?
    end
  end

  describe 'create' do
    describe 'guest users' do
      it 'can create a new review' do
        product = products(:turtleneck)
        review_hash = {
          review: {
            rating: 4,
            description: 'This is great!',
            product_id: product.id
          }
        }
        expect do
          post reviews_path, params: review_hash
        end.must_change 'Review.count', 1
      end

      it 'will give bad request response if there are any errors' do
        review_hash = {
          review: {
            rating: nil,
            description: 'Just okay.',
            product_id: nil
          }
        }

        expect do
          post reviews_path, params: review_hash
        end.wont_change 'Review.count'

        must_respond_with :redirect
        expect(flash[:error]).must_equal 'Save was unsuccessful. Try again!'
      end
    end # end of logged in users block

    describe 'logged in users' do
      it 'cannot leave a review for their own products' do
        perform_login
        review_hash = {
          review: {
            rating: 4,
            description: 'This is great!',
            product_id: products(:turtleneck).id
          }
        }

        expect do
          post reviews_path, params: review_hash
        end.wont_change 'Review.count'

        expect(flash[:error]).must_equal 'You cannot review your own products!'
      end
    end
  end
end
