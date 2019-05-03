# frozen_string_literal: true

require "test_helper"

describe CategoriesController do
  describe "new" do
    it "should get new" do
      get new_category_path
      value(response).must_be :success?
    end
  end

  describe "create" do
    it "can create a new category" do
      category_hash = {
        category: {
          name: "Test Category",
        },
      }

      expect do
        post categories_path, params: category_hash
      end.must_change "Category.count", 1
    end

    it "will give bad request response if there are any errors" do
      category_hash = {
        category: {
          name: "",
        },
      }

      expect do
        post categories_path, params: category_hash
      end.wont_change "Category.count"

      must_respond_with :bad_request
    end
  end

  describe "show" do
    it "should show a list of products sold in that category" do
      category = categories(:fun)

      get category_path(category.id)

      must_respond_with :success
    end

    it "will redirect if we try to view products from an invalid user" do
      get category_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find category with id: -1"
    end
  end
end
