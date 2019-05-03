require "test_helper"

describe OrderitemsController do
  describe "create" do
    it "will save a new orderitem and redirect to cart if given valid inputs and that orderitem doesn't already exist" do
      product_id = products(:turtleneck).id
      quantity = 1

      test_input = {
        "product_id": product_id,
      }

      expect {
        post orderitems_path, params: test_input
      }.must_change "Orderitem.count", 1

      order_id = Order.last.id

      new_orderitem = Orderitem.find_by(order_id: order_id, product_id: product_id)

      expect(new_orderitem).wont_be_nil
      expect(new_orderitem.order_id).must_equal order_id
      expect(new_orderitem.product_id).must_equal product_id
      expect(new_orderitem.quantity).must_equal quantity

      must_respond_with :redirect
      must_redirect_to order_path(order_id)
    end

    it "will add quantity to an existing orderitem and redirect to cart if given valid inputs" do
      product_id = products(:turtleneck).id
      quantity = 1

      test_input = {
        "product_id": product_id,
      }

      expect {
        post orderitems_path, params: test_input
      }.must_change "Orderitem.count", 1

      expect {
        post orderitems_path, params: test_input
      }.wont_change "Orderitem.count"

      order_id = Order.last.id

      new_orderitem = Orderitem.find_by(order_id: order_id, product_id: product_id)

      expect(new_orderitem).wont_be_nil
      expect(new_orderitem.order_id).must_equal order_id
      expect(new_orderitem.product_id).must_equal product_id
      expect(new_orderitem.quantity).must_equal quantity + 1

      must_respond_with :redirect
      must_redirect_to order_path(order_id)
    end

    it "will give a 400 error with invalid params" do
      product_id = nil
      test_input = {
        "product_id": product_id,
      }
      expect {
        post products_path, params: test_input
      }.wont_change "Product.count"

      must_respond_with :redirect
    end
  end
end
