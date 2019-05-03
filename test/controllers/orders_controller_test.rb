require "test_helper"

describe OrdersController do
  it "should get index" do
    get orders_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get orders_show_url
    value(response).must_be :success?
  end

  it "should get create" do
    get orders_create_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get orders_destroy_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get orders_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get orders_update_url
    value(response).must_be :success?
  end

  it "should get submit" do
    get orders_submit_url
    value(response).must_be :success?
  end

  it "should get cust_info" do
    get orders_cust_info_url
    value(response).must_be :success?
  end

  it "should get empty_order" do
    get empty_order_path
    value(response).must_be :success?
  end
end
