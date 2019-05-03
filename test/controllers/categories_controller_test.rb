# frozen_string_literal: true

require 'test_helper'

describe CategoriesController do
  describe 'new' do
    it 'should get new' do
      get new_category_path
      value(response).must_be :success?
    end
  end

  describe 'create' do
    it 'can create a new category' do
      category_hash = {
        category: {
          name: 'Test Category'
        }
      }

      expect do
        post categories_path, params: category_hash
      end.must_change 'Category.count', 1
    end

    it 'will give bad request response if there are any errors' do
      category_hash = {
        category: {
          name: ''
        }
      }

      expect do
        post categories_path, params: category_hash
      end.wont_change 'Category.count'

      must_respond_with :bad_request
    end
  end
 end
