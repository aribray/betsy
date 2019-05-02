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

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
