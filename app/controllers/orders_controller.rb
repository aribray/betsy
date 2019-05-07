
class OrdersController < ApplicationController
  before_action :find_order

  def show
    @order = Order.find_by(id: params[:id])
    # raise
    if @order.nil?
      flash[:failure] = "That order doesn't exist"
      redirect_to root_path, status: :not_found
    end
  end

  def cart
    @order = @current_order

    if @order.orderitems == []
      session[:order_id] = nil
      redirect_to empty_order_path
    end
  end

  def create
    @order = Order.new
    if @order.save
      redirect_to cart_path
    else
      @order.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def destroy
    @current_order.destroy
    flash[:success] = "Successfully destroyed order ##{@current_order.id}"
    session[:order_id] = nil
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def checkout
    @order = @current_order
  end

  def submit
    is_successful = @current_order.update(order_params)
    if is_successful
      redirect_to confirmation_path
    else
      render :checkout, status: :bad_request
    end
  end

  def confirmation
    @order = @current_order
    if @current_order.attributes.values.include?(nil)
      redirect_to checkout_path
      # flush out this validation to show specific errors
      flash[:error] = "Please enter your info into all fields."
    end
    @order.status = :paid
    session[:order_id] = nil
    @order.orderitems.each do |order_item|
      order_item.product.quantity -= order_item.quantity
      order_item.product.save
    end
  end

  def empty_order; end

  def order_params
    params.require(:order).permit(:address, :email, :uid, :cc_name, :cc_number, :zipcode, :cvv, :cc_expiration)
  end
end
