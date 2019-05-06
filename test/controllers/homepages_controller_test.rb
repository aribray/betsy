require "test_helper"

describe HomepagesController do
  describe "index" do
    it "should get index" do
      get root_path
      value(response).must_be :success?
    end
  end
end
