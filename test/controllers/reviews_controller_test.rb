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
    it 'can create a new review' do
      product = products(:turtleneck)
      review_hash = {
        review: {
          rating: 4,
          description: "This is great!",
          product: product.id
        }
      }

      expect{
        post reviews_path, params: review_hash
      }.must_change 'Review.count', 1
    end

    # it 'will give bad request response if there are any errors' do
    #   review_hash = {
    #     review: {
          
    #       description: "Just okay."
    #     }
    #   }

    #   expect do
    #     post reviews_path, params: review_hash
    #   end.wont_change 'Review.count'

    #   must_respond_with :bad_request
    # end
  end
end
