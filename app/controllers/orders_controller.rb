class OrdersController < ApplicationController
  before_action :find_order

  def show
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      flash[:error] = "Could not find order with id: #{params[:id]}"
      redirect_to root_path, status: 302
    end
  end

  def create
    @order = Order.new
    if @order.save
      flash[:success] = "Order created successfully"
      redirect_to order_path(@order.id)
    else
      @order.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
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
