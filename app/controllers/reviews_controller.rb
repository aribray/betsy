# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    @product = Product.find_by(id: params[:product_id])
    @review = Review.new(review_params)

    if @current_user
      if @current_user.id == @product.user_id
        flash[:error] = "You cannot review your own products!"
        redirect_to product_path(@product.id)
        return
      end
    end
    if @review.save
      redirect_to product_path(@product.id)
    else
      flash[:error] = "Save was unsuccessful. Try again!"
      # binding.pry
      render :_new
    end
  end

  private

  def review_params
    params.permit(:review, :rating, :description, :product_id)
  end
end
