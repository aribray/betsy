# frozen_string_literal: true

require "test_helper"
require "pry"

describe ProductsController do
  let(:existing_product) { products(:turtleneck) }
  let(:new_merchant) { users(:merchant) }

  describe "index" do
    it "should get index" do
      get products_path

      must_respond_with :success
    end
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

  describe "new" do
    it "succeeds" do
      perform_login(users(:dee))
      get new_product_path

      must_respond_with :success
    end

    it "redirects if user is not logged in" do
      get new_product_path
      must_respond_with :redirect
    end
  end

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

        expect do
          post products_path, params: test_input
        end.must_change "Product.count", 1

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
        expect do
          post products_path, params: test_input
        end.wont_change "Product.count"

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

        expect do
          post products_path, params: test_input
        end.wont_change "Product.count"

        new_product = Product.find_by(name: input_name)
        expect(new_product).must_equal nil
        expect(flash[:error]).must_equal "You must be logged in to do this action"
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end
  end

  describe "edit" do
    describe "logged in users" do
      before do
        perform_login(users(:dee))
      end

      it "should get edit" do
        get edit_product_path(Product.first.id)

        must_respond_with :success
      end

      it "should respond with error message if the product doesn't exist" do
        get edit_product_path(-1)

        expect(flash[:error]).must_equal "Could not find this product."
        must_respond_with :redirect
      end
    end

    describe "Guest users (not logged in)" do
      it "should respond with found and error message to prompt user to log in" do
        get edit_product_path(Product.first.id)

        must_respond_with :found
        expect(flash[:error]).must_equal "You must be logged in to do this action"
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end

    describe "update" do
      describe "update as a logged in user/merchant" do
        before do
          perform_login(users(:dee))

          input_photo_url = "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM"
          input_description = "black, lightweight, breathable wool turtleneck, perfect for those moments when you're sweating your scam."
          input_name = "Iconic Tech Turtleneck"
          input_price = 9900
          input_quantity = 20
          input_user_id = users(:dee).id
          @test_input = {
            photo_url: input_photo_url,
            description: input_description,
            name: input_name,
            price: input_price,
            quantity: input_quantity,
            user_id: input_user_id,
          }

          @product_to_update = Product.create(@test_input)
        end

        it "will update an existing product" do
          updated_input_description = "a sleak black, lightweight, breathable wool turtleneck, perfect for those moments when you're sweating your scam"

          updated_test_input = {
            "product": {
              description: updated_input_description,
            },
          }

          expect do
            patch product_path(@product_to_update.id), params: updated_test_input
          end.wont_change "Product.count"

          must_respond_with :redirect
          @product_to_update.reload
          expect(@product_to_update.name).must_equal @test_input[:name]
          expect(@product_to_update.user_id).must_equal User.find(@test_input[:user_id]).id
          expect(@product_to_update.description).wont_equal @test_input[:description]
          expect(@product_to_update.description).must_equal updated_input_description
          expect(flash[:success]).must_equal "Product updated successfully!"
        end

        it "will return a bad_request when asked to update with invalid data" do
          bad_input_name = ""
          updated_test_input = {
            "product": {
              name: bad_input_name,
            },
          }

          expect do
            patch product_path(@product_to_update.id), params: updated_test_input
          end.wont_change "Product.count"

          must_respond_with :bad_request
          @product_to_update.reload
          expect(@product_to_update.name).must_equal @test_input[:name]
          expect(@product_to_update.user_id).must_equal User.find(@test_input[:user_id]).id
          expect(@product_to_update.description).must_equal @test_input[:description]
          expect(flash[:name]).must_equal ["can't be blank"]
        end
      end

      describe "update as Guest" do
        it "should respond with found and error message to prompt user to login" do
          patch product_path(Product.first.id)

          must_respond_with :found
          expect(flash[:error]).must_equal "You must be logged in to do this action"
          must_respond_with :redirect
          must_redirect_to root_path
        end
      end
    end
  end

  describe "retire" do
    describe "logged in user" do
      it "should change the retired status of the product" do
        perform_login

        patch retire_path(existing_product.id)
        must_respond_with :found
        expect(existing_product.reload.retired).must_equal true
      end

      it "will raise an error and redirect to root path for nonexistent product" do
        perform_login

        patch retire_path(-1)

        must_respond_with :redirect
        expect(flash[:error]).must_equal "Could not find this product"
      end
    end

    describe "logged out user" do
      it "should respond with found and error message to prompt user to login" do
        patch retire_path(Product.first.id)

        must_respond_with :found
        expect(flash[:error]).must_equal "You must be logged in to do this action"
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end
  end
end
