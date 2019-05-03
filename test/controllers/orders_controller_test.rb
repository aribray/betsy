require "test_helper"

describe OrdersController do
  describe "show" do
    it "should get show" do
      get orders_path
      value(response).must_be :success?
    end

    it "should show a list of products in cart" do
      order = orders(:one)
      get order_path(order.id)
      must_respond_with :success
    end

    it "will redirect if we try to view products from an invalid user" do
      get order_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find order with id: -1"
    end

    it "can't view another user's cart" do
      # implement this later, if there's time
    end
  end

  # it "should get create" do
  #   get orders_create_url
  #   value(response).must_be :success?
  # end

  # it "should get destroy" do
  #   get orders_destroy_url
  #   value(response).must_be :success?
  # end

  # it "should get edit" do
  #   get orders_edit_url
  #   value(response).must_be :success?
  # end

  # it "should get update" do
  #   get orders_update_url
  #   value(response).must_be :success?
  # end

  # it "should get submit" do
  #   get orders_submit_url
  #   value(response).must_be :success?
  # end

  # it "should get cust_info" do
  #   get orders_cust_info_url
  #   value(response).must_be :success?
  # end

  describe "empty_order" do
    it "should get empty_order" do
      get empty_order_path
      value(response).must_be :success?
    end
  end
end
