class OrdersController < ApplicationController
  def index
  end

  def show
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      flash[:error] = "Could not find order with id: #{params[:id]}"
      redirect_to root_path, status: 302
    end
  end

  def create
    # set session[:order_id]?
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def submit
  end

  def cust_info
  end

  # This is so there can be a "cart" even when there's no order started
  def empty_order; end
end
