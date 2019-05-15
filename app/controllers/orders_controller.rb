# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_order, except: [:empty_order]
  before_action :require_login, only: [:show]

  def show
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      flash[:failure] = "That order doesn't exist"
      redirect_to root_path
      return
    end
    user_products = @current_user.orderitems.map(&:product)

    if @order.orderitems == []
      flash[:error] = "You don't have access to do that."
      redirect_to root_path
      return
    end

    @order.orderitems.each do |oi|
      next if user_products.include?(oi.product)

      flash[:error] = "You don't have access to do that."
      redirect_to root_path
      return
    end
  end

  def cart
    @order = @current_order

    if @order.orderitems == []
      session[:order_id] = nil
      redirect_to empty_order_path
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
    errors = {
      cc_name: 'Credit Card Name cannot be blank.',
      cc_number: 'Please enter a valid credit card number.',
      cvv: 'Please enter a valid CVV.',
      cc_expiration: 'Please enter a valid credit card expiration date.',
      email: 'Please enter your email address.',
      address: 'Please enter your address.',
      zipcode: 'Please enter your zipcode.'
    }

    if @order.cc_name == '' || @order.cc_number.nil? || @order.cvv.nil? || @order.cc_expiration.nil? || @order.email == '' || @order.address == '' || @order.zipcode.nil?
      error = true
      flash[:error] = []
    end

    flash[:error] << errors[:cc_name] if @order.cc_name == ''
    flash[:error] << errors[:cc_number] if @order.cc_number.nil?
    flash[:error] << errors[:cvv] if @order.cvv.nil?
    flash[:error] << errors[:cc_expiration] if @order.cc_expiration.nil?
    flash[:error] << errors[:email] if @order.email == ''
    flash[:error] << errors[:address] if @order.address == ''
    flash[:error] << errors[:zipcode] if @order.zipcode.nil?

    if error == true
      redirect_to checkout_path
    else
      @order.status = 'paid'
      session[:order_id] = nil
      @order.orderitems.each do |order_item|
        order_item.product.quantity -= order_item.quantity
        order_item.product.save
      end
      @order.save
    end
  end

  def empty_order
    redirect_to cart_path if session[:order_id]
  end

  def order_params
    params.require(:order).permit(:address, :email, :uid, :cc_name, :cc_number, :zipcode, :cvv, :cc_expiration)
  end
end
