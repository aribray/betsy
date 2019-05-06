# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_order
  before_action :find_individual_product, only: %i[show edit update retire]
  before_action :require_login, only: %i[new create edit update retire]

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
    @product = Product.new(product_params)
    @product.user_id = @current_user.id if @current_user
    if @product.save
      flash[:success] = 'Product added successfully'
      redirect_to product_path(@product.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      flash[:error] = 'Could not find this product.'
      redirect_back fallback_location: products_path
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product updated successfully!'
      redirect_to product_path(@product.id)
    else
      @product.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def retire
    if @product.nil?
      flash[:error] = 'Could not find this product'
      redirect_to root_path
      return
    end

    if @product.retired == false
      @product.retired = true
    elsif @product.retired == true
      @product.retired = false
    end
    @product.save
    redirect_to myaccount_path
  end

  private

  def find_individual_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:photo_url, :description, :name, :price, :quantity, :user_id)
  end
end
