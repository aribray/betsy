# frozen_string_literal: true

class OrderitemsController < ApplicationController
  before_action :find_order
  before_action :select_product

  def create # should some of this logic be in "update"? not sure how that would work, but this works fine for now
    current_order = @current_order

    # If cart already has this product then find the relevant order_item and iterate quantity otherwise create a new order_item for this product
    if current_order.products.include?(@chosen_product)
      order_item = current_order.orderitems.find_by(product_id: @chosen_product.id)
      # Iterate the order_item's quantity by one (or by different amount, depending on later functionality)
      order_item.quantity += 1
    else
      order_item = Orderitem.new
      order_item.product_id = @chosen_product.id
      order_item.order_id = current_order.id
      order_item.quantity = 1 # or given amount when adding to cart, if we eventually give users that option
    end

    is_successful = order_item.save
    if is_successful
      redirect_to order_path(current_order.id)
    else
      # figure out what we want to do here later
      redirect_to root_path
    end
  end

  def edit; end

  def update; end

  def destroy
    @order_item = Orderitem.find_by(id: params[:orderitem_id])
    @order_item.destroy
    redirect_to order_path(@current_order.id)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :cart_id)
  end

  def select_product
    @chosen_product = Product.find_by(id: params[:product_id])
  end
end
