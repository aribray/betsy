# frozen_string_literal: true

class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @product = Product.find_by(id: @review.product_id)

    if @current_user
      if @current_user.id == @product.user_id
        flash[:error] = 'You cannot review your own products!'
        redirect_to product_path(@review.product_id)
      end
    elsif @review.save
      redirect_to product_path(@review.product_id)
    else
      flash[:error] = 'Save was unsuccessful. Try again!'
      redirect_to root_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end
end
