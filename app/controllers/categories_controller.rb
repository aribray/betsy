# frozen_string_literal: true

class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    is_successful = @category.save

    if is_successful
      redirect_to root_path # actually figure out where to redirect to. I'm thinking the user myaccount page
    else
      render :new, status: :bad_request
    end
  end

  def show
    @category = Category.find_by(id: params[:id])
    if @category.nil?
      flash[:error] = "Could not find category with id: #{params[:id]}"
      redirect_to root_path, status: 302
    end
    @products = @category.products.where("quantity > ?", 0).sort_by { |product| product.created_at }.reverse
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
