require "test_helper"

describe UsersController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should show a list of products sold by the user" do
      user = users(:dee)

      get user_path(user.id)

      must_respond_with :success
    end

    it "will redirect if we try to view products from an invalid user" do
      get user_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find user with id: -1"
    end
  end

  describe "login" do
    it "can log in an existing user" do
      user_count = User.count

      user = perform_login

      expect(user_count).must_equal User.count

      expect(flash[:success]).must_equal "Logged in as returning user #{user.name}"

      expect(session[:user_id]).must_equal user.id
    end

    it "can log in a new user" do
      user = User.new(provider: "github", name: "bob", username: "bobbi", uid: 987, email: "bob@hope.com")
      expect {
        perform_login(user)
      }.must_change "User.count", 1

      expect(flash[:success]).must_equal "Logged in as new user #{user.name}"
      user = User.find_by(uid: user.uid, provider: user.provider)

      expect(session[:user_id]).must_equal user.id
    end

    it "will redirect back to root with a flash message if not coming from github" do
      # Skip Auth hash creation (from notes?)
      # probably just ignore everything below... it doesn't work

      # # user = User.new(provider: "github", name: "bob", username: "bobbi", uid: 987, email: "bob@hope.com")
      # delete logout_path
      # # expect {
      # # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      # # binding.pry

      # # get auth_callback_path(:haha)

      # must_respond_with :redirect
      # must_redirect_to root_path
      # # }.wont_change "User.count"

      # # expect(flash[:success]).must_equal "Logged in as new user"
      # # user = User.find_by(uid: user.uid, provider: user.provider)

      # # expect(session[:user_id]).must_equal user.id

      # # user = User.new(provider: "github", name: "bob", username: "bobbi", uid: 987, email: "bob@hope.com")

      # # # perform_login

      # # user ||= users(:dee)

      # # # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # # get auth_callback_path(:github)

      # # # return user

      # # # expect(session[:user_id]).must_be_nil
      # expect(flash[:success]).must_equal "Could not create new user account"

      # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      #   {
      #     provider: "github",
      #     uid: user.uid,
      #     info: {
      #       email: user.email,
      #       nickname: user.username,
      #       name: user.name,
      #     },
      #   }
      # )

      # get auth_callback_path(:github)

      # must_respond_with :redirect
      # must_redirect_to root_path

      # # expect {
      # #   login_path, params:
      # # }.wont_change "User.count"

      # expect(flash[:error]).must_equal "Could not create new user account: #{user.errors.messages}"
      # # user = User.find_by(uid: user.uid, provider: user.provider)

      # expect(session[:user_id]).must_equal nil

      # must_respond_with :redirect
      # must_redirect_to root_path
    end
  end

  describe "logout" do
    it "logs out the current user" do
      user = users(:dee)
      perform_login(user)
      delete logout_path(user)
      expect(flash[:success]).must_equal "Successfully logged out!"
      must_respond_with :redirect
    end
  end

  describe "myaccount" do
    it "should get myaccount if logged in" do
      perform_login

      get myaccount_path
      must_respond_with :success
    end

    it "should redirect to homepage and flash error if not logged in" do
      get myaccount_path
      must_respond_with :redirect
      must_redirect_to root_path

      flash[:error].must_equal "You must be logged in to do that."
    end
  end

  describe "myorders" do
    it "should get myorders if logged in" do
      perform_login

      get myorders_path
      must_respond_with :success
    end

    it "should redirect to homepage and flash error if not logged in" do
      get myorders_path
      must_respond_with :redirect
      must_redirect_to root_path

      flash[:error].must_equal "You must be logged in to do that."
    end
  end
end
