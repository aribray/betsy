require "test_helper"

describe ProductsController do
  let(:existing_product) { products(:turtleneck) }

  it "should get index" do
    get products_index_url
    value(response).must_be :success?
  end

  describe "show" do
    it "succeeds for an extant product ID" do
      get product_path(existing_product.id)

      must_respond_with :success
    end

    it "renders 404 not_found for a bogus product ID" do
      destroyed_id = existing_product.id
      existing_product.destroy

      get product_path(destroyed_id)

      must_respond_with :not_found
    end
  end

  it "should get new" do
    get products_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get products_create_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get products_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get products_update_url
    value(response).must_be :success?
  end

  it "should get retire" do
    get products_retire_url
    value(response).must_be :success?
  end
end
