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

  describe "cart" do
    it "shows cart if session id is not nil" do
      @current_order = create_cart
      get cart_path
      must_respond_with :success
    end

    it "redirect to empty order if no orderitems exist" do
      get cart_path
      expect(session[:order_id]).must_be_nil
      must_respond_with :redirect
    end
  end

  describe "create" do
  end

  describe "submit" do
    before do
      @current_order = create_cart
    end
    it "updates order data and redirects" do
      input_cc_name = "Divine"
      input_cc_number = 1234556
      input_cvv = 123
      input_expiration_date = 1220
      input_address = "555 Scammer Lane"
      input_zipcode = 98105
      input_email = "divine@scams.net"
      update_input = {
        "order": {
          cc_name: input_cc_name,
          cc_number: input_cc_number,
          cvv: input_cvv,
          address: input_address,
          zipcode: input_zipcode,
          email: input_email,
        },
      }
      expect do
        patch submit_path, params: update_input
      end.wont_change "Order.count"
      @current_order.reload
      expect(@current_order.cc_name).must_equal input_cc_name
      expect(@current_order.cc_number).must_equal input_cc_number
      expect(@current_order.cvv).must_equal input_cvv
      expect(@current_order.zipcode).must_equal input_zipcode
      must_respond_with :redirect
    end
  end

  describe "confirmation" do
    before do
      @current_order = create_cart
    end
    it "should get confirmation page, change status to paid, and update product quantity if given valid params" do
      input_cc_name = "Divine"
      input_cc_number = 1234556
      input_cvv = 123
      input_expiration_date = 122020
      input_address = "555 Scammer Lane"
      input_zipcode = 98105
      input_email = "divine@scams.net"
      update_input = {
        "order": {
          cc_name: input_cc_name,
          cc_number: input_cc_number,
          cvv: input_cvv,
          address: input_address,
          zipcode: input_zipcode,
          email: input_email,
          cc_expiration: input_expiration_date,
        },
      }
      expect do
        patch submit_path, params: update_input
      end.wont_change "Order.count"
      get confirmation_path
      @current_order.reload
      product = Product.find(@current_order.orderitems.first.product_id)
      must_respond_with :success
      expect(session[:order_id]).must_be_nil
      expect(product.quantity).must_equal 18
      expect(@current_order.cc_name).must_equal input_cc_name
      expect(@current_order.cc_number).must_equal input_cc_number
      expect(@current_order.cvv).must_equal input_cvv
      expect(@current_order.zipcode).must_equal input_zipcode
      expect(@current_order.status).must_equal "paid"
    end
    it "should redirect if given invalid params" do
      input_cc_name = ""
      input_cc_number = 12323434534
      input_cvv = 123
      input_expiration_date = 123000
      input_address = "6007 NE Hawkins Dr."
      input_zipcode = 12318
      input_email = "scams@scamfam.bam"
      update_input = {
        "order": {
          cc_name: input_cc_name,
          cc_number: input_cc_number,
          cvv: input_cvv,
          address: input_address,
          zipcode: input_zipcode,
          email: input_email,
          cc_expiration: input_expiration_date,
        },
      }
      expect do
        patch submit_path(@current_order.id), params: update_input
      end.wont_change "Order.count"
      get confirmation_path
      must_respond_with :redirect
      product = Product.find(@current_order.orderitems.first.product_id)
      expect(product.quantity).must_equal 20
      expect(@current_order.status).must_equal "pending"
      expect(flash[:error]).must_equal "Credit Card Name cannot be blank."
    end
  end

  describe "destroy" do
    before do
      @current_order = create_cart
    end
    it "deletes current order" do
      expect do
        delete order_path(@current_order.id)
      end.must_change "Order.count", -1
    end
    it "sets session order id to nil and redirects" do
      delete order_path(@current_order.id)
      must_respond_with :redirect
      expect(session[:order_id]).must_be_nil
    end
  end

  describe "empty_order" do
    it "should get empty_order" do
      get empty_order_path
      value(response).must_be :success?
    end
    # add edge cases
  end
end
