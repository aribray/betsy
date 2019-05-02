# frozen_string_literal: true

require 'test_helper'

describe UsersController do
  # will need describe logged in users and describe guest users distinction
  describe 'index' do
    it 'should get index' do
      get users_path
      value(response).must_be :success?
    end
  end

  describe 'show' do
    it 'should show a list of products sold by the user' do
      user = users(:one)

      get user_path(user.id)

      must_respond_with :success
    end

    it 'will redirect if we try to view products from an invalid user' do
      get user_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find user with id: -1'
    end
  end

  # it "should get login" do
  #   get users_login_url
  #   value(response).must_be :success?
  # end

  # it "should get logout" do
  #   get users_logout_url
  #   value(response).must_be :success?
  # end
end
