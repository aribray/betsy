# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"
require File.expand_path("../config/environment", __dir__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters" # for Colorized output
#  For colorful output!
require "simplecov"
SimpleCov.start

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup
    OmniAuth.config.test_mode = true
  end

  def mock_auth_hash(user)
    return {
             provider: user.provider,
             uid: user.uid,
             info: {
               email: user.email,
               nickname: user.username,
               name: user.name,
             },
           }
  end

  def perform_login(user = nil)
    user ||= users(:dee)

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

    get auth_callback_path(:github)

    must_respond_with :redirect
    must_redirect_to root_path

    return user
  end
end
