# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :find_user, :set_cache_headers

  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    current_user = User.find_by(id: session[:user_id])
    if current_user.nil?
      flash[:error] = "You must be logged in to do this action"
      redirect_to root_path
    end
  end

  def find_order
    if session[:order_id]
      @current_order = Order.find_by(id: session[:order_id])
    else
      @current_order = Order.create
      session[:order_id] = @current_order.id
    end
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
