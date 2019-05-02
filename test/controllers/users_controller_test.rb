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

  describe "login" do
    it "can log in an existing user" do
      user_count = User.count
      user = perform_login

      expect(user_count).must_equal User.count
      expect(session[:user_id]).must_equal user.id
    end

    it "can log in a new user" do
      user = User.new(provider: "github", username: "bob", uid: 987, email: "bob@hope.com")

      expect {
        perform_login(user)
      }.must_change "User.count", 1

      user = User.find_by(uid: user.uid, provider: user.provider)

      expect(session[:user_id]).must_equal user.id
    end

    it "will redirect back to root with a flash message if not coming from github" do
      # Skip Auth hash creation
    end
  end

  describe "current" do
    it "responds with success if a user is logged in" do
      logged_in_user = perform_login
      get current_user_path
      must_respond_with :success
    end

    it "responds with a redirect if no user is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end
end
