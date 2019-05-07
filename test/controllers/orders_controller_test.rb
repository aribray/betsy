require "test_helper"

describe OrdersController do
  describe "show" do
    it "should get show" do
      order = orders(:one)
      get order_path(order.id)
      value(response).must_be :success?
    end

    it "will respond with 404 if the order is not found" do
      invalid_order_id = -1

      get order_path(invalid_order_id)
      must_respond_with :not_found
    end

    # it "can't view another user's cart" do
    #   # implement this later, if there's time
    # end
  end

  describe "empty_order" do
    it "should get empty_order" do
      get empty_order_path
      value(response).must_be :success?
    end
  end
end
