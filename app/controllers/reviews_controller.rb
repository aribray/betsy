# frozen_string_literal: true

class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    if review.save
      redirect_to review_path(review.id)
    else
      flash[:error] = 'Save was unsuccessful. Try again!'
      redirect_to root_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
