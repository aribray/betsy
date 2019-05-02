class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      head :not_found
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def retire
  end
end
