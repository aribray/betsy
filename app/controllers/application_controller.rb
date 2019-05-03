class ApplicationController < ActionController::Base
  # frozen_string_literal: true	
  before_action :current_order	

   private	

   def current_order	
    if session[:order_id]	
      order = Order.find_by(id: session[:order_id])	
      if order.present?	
        @current_order = order	
      else	
        session[:order_id] = nil	
      end	
    end	

     if session[:order_id].nil?	
      @current_order = Order.create	
      session[:order_id] = @current_order.id	
    end	
  end	
end
