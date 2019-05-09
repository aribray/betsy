require "test_helper"

describe ApplicationHelper do
  describe "stars" do
    it "produces stars" do
      product = products(:turtleneck)

      result = stars(product)

      expect(result).must_include "☆"
      expect(result.length).must_equal 5
    end
  end
end
