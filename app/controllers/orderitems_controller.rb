# frozen_string_literal: true

class OrderitemsController < ApplicationController
  def edit; end

  def update
      # Find associated product and current cart
      chosen_product = Product.find_by(id: params[:product_id])
      current_order = @current_order
    
      # If cart already has this product then find the relevant order_item and iterate quantity otherwise create a new order_item for this product
      if current_order.products.include?(chosen_product)
        # Find the order_item with the chosen_product
        @order_item = current_order.order_items.find_by(product_id: chosen_product.id)
        # Iterate the order_item's quantity by one
        @order_item.quantity += 1
      else
        @order_item = Orderitem.new
        @order_item.product_id = chosen_product.id
        @order_item.order_id = current_order.id
      end
      # Save and redirect to cart show path
      @order_item.save
      redirect_to order_path(current_order.id)
    end

    def destroy
      @order_item = Orderitem.find_by(id: params[:id])
      @order_item.destroy
      redirect_to order_path(@current_order.id)
    end 
    
    private

      def order_item_params
        params.require(:order_item).permit(:quantity,:product_id, :cart_id)
     end

end
