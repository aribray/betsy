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

  describe "checkout" do
    it "should get checkout page" do
      get checkout_path

      must_respond_with :success
    end
  end

  describe "confirmation" do
    it "if given valid params, changes status to paid" do
      #redirects to confirmation and returns success
      # input_cc_name = "Divine"
      # input_cc_number = 1234556
      # input_cvv = 123
      # input_expiration_date = 1220
      # input_address = "555 Scammer Lane"
      # input_zipcode = 98105
      # input_email = "divine@scams.net"
      # update_input = {
      #   "order": {
      #     cc_name: input_cc_name,
      #     cc_number: input_cc_number,
      #     cvv: input_cvv,
      #     address: input_address,
      #     zipcode: input_zipcode,
      #     email: input_email,
      #   },
      # }

      # get confirmation_path, params: update_input

      # expect(@current_order.cc_name).must_equal "Divine"
      # expect(@current_order.status).must_equal :paid
      # must_respond_with :success
    end
    # it "should get confirmation page" do
    #   get confirmation_path

    #   must_respond_with :success
    # end
    # it "should give a 400 error if given invalid params"
    # input_cc_name = "Divine"
    # input_cc_number = 1234556
    # input_cvv = nil
    # input_expiration_date = 1220
    # input_address = "555 Scammer Lane"
    # input_zipcode = 98105
    # input_email = "divine@scams.net"
    # update_input = {
    #   "order": {
    #     cc_name: input_cc_name,
    #     cc_number: input_cc_number,
    #     cvv: input_cvv,
    #     address: input_address,
    #     zipcode: input_zipcode,
    #     email: input_email,
    #   },
    # }
    # expect do
    #   patch submit_path(@current_order.id), params: update_input
    # end.wont_change "Order.count"
    # must_respond_with :bad_request
    # expect(@current_order.status).must_equal :paid
    # end
  end

  describe "submit" do
    it "will give a 400 error with invalid params" do
      # input_cc_name = "Divine"
      # input_cc_number = 1234556
      # input_cvv = nil
      # input_expiration_date = 1220
      # input_address = "555 Scammer Lane"
      # input_zipcode = 98105
      # input_email = "divine@scams.net"
      # update_input = {
      #   "order": {
      #     cc_name: input_cc_name,
      #     cc_number: input_cc_number,
      #     cvv: input_cvv,
      #     address: input_address,
      #     zipcode: input_zipcode,
      #     email: input_email,
      #   },
      # }
      # expect do
      #   patch submit_path(@current_order.id), params: update_input
      # end.wont_change "Order.count"
      # must_respond_with :bad_request
      # expect(@current_order.status).must_equal :paid
    end
  end

  describe "destroy" do
    it "deletes current order" do
    end
    it "sets session order id to nil and redirects" do
    end
  end

  describe "empty_order" do
    it "should get empty_order" do
      get empty_order_path
      value(response).must_be :success?
    end
  end
end
