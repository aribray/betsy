# frozen_string_literal: true

class OrderitemsController < ApplicationController
  before_action :find_order
  before_action :select_product
  before_action :require_login, only: [:ship]

  def create # should some of this logic be in "update"? not sure how that would work, but this works fine for now
    current_order = @current_order
    @chosen_product = Product.find_by(id: params[:product_id])

    # If cart already has this product then find the relevant order_item and iterate quantity otherwise create a new order_item for this product
    if current_order.products.include?(@chosen_product)
      order_item = current_order.orderitems.find_by(product_id: @chosen_product.id)
      # Iterate the order_item's quantity by one (or by different amount, depending on later functionality)
      order_item.quantity = params[:quantity].to_i
      flash[:success] = "Successfully updated #{@chosen_product.name} quantity to #{order_item.quantity}"
    else
      order_item = Orderitem.new
      order_item.product_id = @chosen_product.id
      order_item.order_id = current_order.id
      order_item.quantity = params[:quantity].to_i
    end

    is_successful = order_item.save
    if is_successful
      redirect_to cart_path
    else
      # I don't think we'll ever hit this?? Current order either exists or is created, and the product comes from the URL
    end
    return order_item
  end

  def edit; end

  def update; end

  def ship
    @orderitem = Orderitem.find_by(id: params[:id])
    if @orderitem.nil?
      flash[:error] = "Could not find this product"
      redirect_to root_path
      return
    end

    if @orderitem.shipped == false
      @orderitem.shipped = true
    else
      flash[:error] = "This item has already shipped"
    end
    @orderitem.save
    redirect_to myorders_path
  end

  def destroy
    @order_item = Orderitem.find_by(id: params[:orderitem_id])
    name = @order_item.product.name if @order_item
    @order_item.destroy
    redirect_to cart_path

    flash[:success] = "Successfully removed #{name} from cart"
  end

  private

  def select_product
    @chosen_product = Product.find_by(id: params[:product_id])
  end
end
