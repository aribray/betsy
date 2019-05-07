require "test_helper"

describe Order do
  let(:order) { orders(:one) }

  describe "relationships" do
    it "has many orderitems" do
      my_order = order.orderitems

      expect(my_order.length).must_equal 2
      expect(my_order).must_include orderitems(:three)
    end

    it "has many products" do
      my_order = order.products

      expect(my_order.length).must_equal 2
      expect(my_order).must_include products(:turtleneck)
    end
  end

  # we might want to test validations for Orders here
end
