require "test_helper"

describe UsersController do
  describe "login" do
    it "can log in an existing user" do
      user_count = User.count

      user = perform_login

      expect(user_count).must_equal User.count

      expect(flash[:success]).must_equal "Logged in as returning user #{user.name}"

      expect(session[:user_id]).must_equal user.id
    end

    it "can log in a new user" do
      user = User.new(provider: "github", username: "bob", uid: 987, email: "bob@hope.com")

      expect {
        perform_login(user)
      }.must_change "User.count", 1

      expect(flash[:success]).must_equal "Logged in as new user #{user.name}"
      user = User.find_by(uid: user.uid, provider: user.provider)

      expect(session[:user_id]).must_equal user.id
    end

    it "will redirect back to root with a flash message if not coming from github" do
      # Skip Auth hash creation
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
end
