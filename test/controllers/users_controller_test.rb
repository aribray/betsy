require "test_helper"

describe UsersController do
  it "should get index" do
    get users_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get users_show_url
    value(response).must_be :success?
  end

  it "should get login" do
    get users_login_url
    value(response).must_be :success?
  end

  it "should get logout" do
    get users_logout_url
    value(response).must_be :success?
  end

end
