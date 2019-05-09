# frozen_string_literal: true

require "test_helper"
require "pry"

describe OrderitemsController do
  describe "create" do
    it "will save a new orderitem and redirect to cart if given valid inputs and that orderitem doesn't already exist" do
      product_id = products(:turtleneck).id

      orderitem_quantity = 7

      test_input = {
        "product_id": product_id,
        "quantity": orderitem_quantity,
      }

      expect do
        post orderitems_path, params: test_input
      end.must_change "Orderitem.count", 1

      # expect(Orderitem.last).must_be_kind_of Orderitem
      # expect(Orderitem.all.last.quantity).must_equal orderitem_quantity

      order_id = Order.last.id

      new_orderitem = Orderitem.find_by(order_id: order_id, product_id: product_id)

      expect(new_orderitem).must_be_kind_of Orderitem

      expect(new_orderitem.order_id).must_equal order_id
      expect(new_orderitem.product_id).must_equal product_id
      expect(new_orderitem.quantity).must_equal orderitem_quantity

      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "will add quantity to an existing orderitem and redirect to cart if given valid inputs" do
      product_id = products(:turtleneck).id
      quantity = 1

      test_input = {
        "product_id": product_id,
        "quantity": 2,
      }

      expect do
        post orderitems_path, params: test_input
      end.must_change "Orderitem.count", 1

      expect do
        post orderitems_path, params: test_input
      end.wont_change "Orderitem.count"

      order_id = Order.last.id

      new_orderitem = Orderitem.find_by(order_id: order_id, product_id: product_id)

      expect(new_orderitem).wont_be_nil
      expect(new_orderitem.order_id).must_equal order_id
      expect(new_orderitem.product_id).must_equal product_id
      expect(new_orderitem.quantity).must_equal quantity + 1

      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "will give a 400 error with invalid params" do
      product_id = nil
      test_input = {
        "product_id": product_id,
      }
      expect do
        post products_path, params: test_input
      end.wont_change "Product.count"

      must_respond_with :redirect
    end
  end

  describe "ship" do
    describe "logged in users" do
      before do
        @user = perform_login
      end

      it "will change orderitems shipped status to true" do
        item = @user.orderitems.first
        patch ship_path(item.id)

        must_respond_with :redirect
        expect(item.reload.shipped).must_equal true
      end

      it "will flash error if orderitem already shipped" do
        item = @user.orderitems.first
        item.update(shipped: true)
        item.reload

        patch ship_path(item.id)

        must_respond_with :redirect
        flash[:error].must_equal "This item has already shipped"
      end

      it "will flash an error and redirect of the item is not found" do
        patch ship_path(-1)

        must_redirect_to root_path
        expect(flash[:error]).must_equal "Could not find this product"
      end
    end

    describe "logged out users" do
      it "will respond with found and error message to prompt user to login" do
        patch ship_path(Orderitem.first.id)

        must_respond_with :found
        expect(flash[:error]).must_equal "You must be logged in to do this action"
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end

    describe "destroy" do
      before do
        @orderitem = orderitems(:one)
      end
      it "can destroy existing orderitem" do
        name = @orderitem.product.name
        expect do
          delete orderitem_path(@orderitem.id), params: {orderitem_id: @orderitem.id}
        end.must_change "Orderitem.count", -1

        flash[:success].must_equal "Successfully removed #{name} from cart"
      end
    end
  end
end
