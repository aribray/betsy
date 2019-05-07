class OrdersController < ApplicationController
  before_action :find_order

  def show
    @order = Order.find_by(id: params[:id])
    # raise
    if @order.nil?
      flash[:failure] = "That order doesn't exist"
      redirect_to root_path, status: 302
    end
  end

  def cart
    @order = @current_order
    if @order.nil?
      redirect_to root_path, status: 302
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
    # set session[:order_id]?
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

  def submit
    is_successful = @current_order.update(order_params)
    if is_successful
      redirect_to confirmation_path
    else
      render :checkout, status: :bad_request
    end
  end

  def checkout
    @order = @current_order
  end

  def confirmation
    @order = @current_order
  end

  # This is so there can be a "cart" even when there's no order started
  def empty_order; end

  def order_params
    params.require(:order).permit(:address, :email, :uid, :cc_name, :cc_number, :zipcode, :cvv, :cc_expiration)
  end
end
