
class OrdersController < ApplicationController
  before_action :find_order

  def show
    @order = Order.find_by(id: params[:id])
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

  def checkout
    @order = @current_order
  end

  def submit
    @current_order.update(order_params)
    redirect_to confirmation_path
  end

  def confirmation
    @order = @current_order
    error = false
    flash[:error] = []
    errors = {
      :cc_name => "Credit Card Name cannot be blank.",
      :cc_number => "Please enter a valid credit card number.",
      :cvv => "Please enter a valid CVV.",
      :cc_expiration => "Please enter a valid credit card expiration date.",
      :email => "Please enter your email address.",
      :address => "Please enter your address.",
      :zipcode => "Please enter your zipcode.",
    }

    if @order.cc_name == ""
      flash[:error] << errors[:cc_name]
      error = true
    end
    if @order.cc_number == nil
      flash[:error] << errors[:cc_number]
      error = true
    end
    if @order.cvv == nil
      flash[:error] << errors[:cvv]
      error = true
    end
    if @order.cc_expiration == nil
      flash[:error] << errors[:cc_expiration]
      error = true
    end
    if @order.email == ""
      flash[:error] << errors[:email]
      error = true
    end
    if @order.address == ""
      flash[:error] << errors[:address]
      error = true
    end
    if @order.zipcode == nil
      flash[:error] << errors[:zipcode]
      error = true
    end

    if error == true
      redirect_to checkout_path
    else
      @order.status = "paid"
      session[:order_id] = nil
      @order.orderitems.each do |order_item|
        order_item.product.quantity -= order_item.quantity
        order_item.product.save
      end
      @order.save
    end
  end

  def empty_order; end

  def order_params
    params.require(:order).permit(:address, :email, :uid, :cc_name, :cc_number, :zipcode, :cvv, :cc_expiration)
  end
end
