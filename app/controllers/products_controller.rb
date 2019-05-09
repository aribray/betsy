# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_order
  before_action :find_individual_product, only: %i[show edit update retire]
  before_action :require_login, only: %i[new create edit update retire]

  def index
    @products = Product.where("quantity > ?", 0)
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
    @product.categories.build
  end

  def create
    @product = Product.new(product_params)

    categories = split(params)
    @product.categories << categories

    @product.user_id = @current_user.id if @current_user
    if @product.save
      flash[:success] = "Product added successfully"
      redirect_to product_path(@product.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      flash[:error] = "Could not find this product."
      redirect_back fallback_location: products_path
    end
  end

  def update
    @product.name = params[:product][:name] if params[:product][:name]
    @product.description = params[:product][:description] if params[:product][:description]
    @product.price = params[:product][:price] if params[:product][:price]
    @product.quantity = params[:product][:quantity] if params[:product][:quantity]
    @product.photo_url = params[:product][:photo_url] if params[:product][:photo_url]

    if params[:product][:categories_attributes] && !params[:product][:categories_attributes]["0"][:name].blank?
      category = Category.new(name: params[:product][:categories_attributes]["0"][:name])
    end
    categories = split(params)
    categories << category if !category.nil? && category.valid?
    @product.categories = categories

    if @product.save
      flash[:success] = "Product updated successfully!"
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
      flash[:error] = "Could not find this product"
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

  def split(params)
    categories = []
    params[:product][:category]&.reject(&:blank?)&.each do |category|
      cat = Category.find_by(id: category)
      categories << cat
    end
    categories
  end

  private

  def find_individual_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:photo_url, :description, :name, :price, :quantity, :user_id, :category, categories_attributes: %i[categories name])
  end
end
