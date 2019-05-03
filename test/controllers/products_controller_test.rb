require "test_helper"

describe ProductsController do
  let(:existing_product) { products(:turtleneck) }
  let(:new_merchant) { users(:merchant) }

  it "should get index" do
    get products_path

    must_respond_with :success
  end

  describe "show" do
    it "should be OK to show an existing, valid product" do
      valid_product_id = existing_product.id

      get product_path(valid_product_id)

      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid product" do
      product = existing_product
      invalid_product_id = product.id
      product.destroy

      get product_path(invalid_product_id)

      must_respond_with :not_found
      expect(flash[:error]).must_equal "Could not find product with id: #{invalid_product_id}"
    end
  end

  # describe "new" do
  #   it "succeeds" do
  #     get new_product_path

  #     must_respond_with :success
  #   end
  # end

  describe "create" do
    describe "logged in users" do
      before do
        perform_login(users(:dee))
        merchant = new_merchant
      end

      it "will save a new product and redirect if given valid inputs" do
        input_photo_url = "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM"
        input_description = "black, lightweight, breathable wool turtleneck, perfect for those moments when you're sweating your scam."
        input_name = "Iconic Tech Turtleneck"
        input_price = 9900
        input_quantity = 20
        input_user_id = new_merchant.id
        test_input = {
          "product": {
            photo_url: input_photo_url,
            description: input_description,
            name: input_name,
            price: input_price,
            quantity: input_quantity,
            user_id: input_user_id,
          },
        }

        expect {
          post products_path, params: test_input
        }.must_change "Product.count", 1

        new_product = Product.find_by(name: input_name)
        expect(new_product).wont_be_nil
        expect(new_product.name).must_equal input_name
        expect(new_product.price).must_equal input_price
        expect(new_product.description).must_equal input_description

        must_respond_with :redirect
      end
      it "will give a 400 error with invalid params" do
        input_photo_url = "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM"
        input_description = "black, lightweight, breathable wool turtleneck, perfect for those moments when you're sweating your scam."
        input_name = ""
        input_price = 9900
        input_quantity = 20
        input_user_id = new_merchant.id
        test_input = {
          "product": {
            photo_url: input_photo_url,
            description: input_description,
            name: input_name,
            price: input_price,
            quantity: input_quantity,
            user_id: input_user_id,
          },
        }
        expect {
          post products_path, params: test_input
        }.wont_change "Product.count"

        expect(flash[:name]).must_equal ["can't be blank"]
        must_respond_with :bad_request
      end
    end

    describe "Not logged in users (Guest Users)" do
      it "will redirect to some page if the user attempts to do this with any input" do
        merchant = new_merchant
        input_photo_url = "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM"
        input_description = "black, lightweight, breathable wool turtleneck, perfect for those moments when you're sweating your scam."
        input_name = "Iconic Tech Turtleneck"
        input_price = 9900
        input_quantity = 20
        input_user_id = merchant.id
        test_input = {
          "product": {
            photo_url: input_photo_url,
            description: input_description,
            name: input_name,
            price: input_price,
            quantity: input_quantity,
            user_id: input_user_id,
          },
        }

        expect {
          post products_path, params: test_input
        }.wont_change "Product.count"

        new_product = Product.find_by(name: input_name)
        expect(new_product).must_equal nil
        expect(flash[:error]).must_equal "You must be logged in to do this action"
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end
  end

  # it "should get edit" do
  #   get products_edit_url
  #   value(response).must_be :success?
  # end

  # it "should get update" do
  #   get products_update_url
  #   value(response).must_be :success?
  # end

  # it "should get retire" do
  #   get products_retire_url
  #   value(response).must_be :success?
  # end
end
