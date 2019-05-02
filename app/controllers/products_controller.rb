class ProductsController < ApplicationController
  before_action :find_individual_product, only: [:show, :edit, :update, :retire]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      flash[:error] = "Could not find product with id: #{params[:id]}"
      redirect_to root_path, status: 302
      head :not_found
    end
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to product_path(product.id)
    else
      flash[:error] = "Save was unsuccessful. Try again!"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @product.nil?
      flash[:error] = "Could not find product with id: #{params[:id]}"
    else
      @product.update_attributes(product_params)
      flash[:success] = "Product Updated"
      redirect_to product_path(product.id)
    end
  end

  def retire
    if @product.nil?
      flash[:error] = "Could not find product with id: #{params[:id]}"
    elsif @product.retired == false
      @product.retired = true
    elsif @product.retired == true
      @product.retired = false
    end
  end

  private

  def find_individual_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:photo_url, :description, :name, :price, :quantity, :user_id)
  end
end
