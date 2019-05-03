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
end
