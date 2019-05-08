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

    it "will delete an orderitem when destroyed" do
      my_order = order

      expect {
        my_order.destroy
      }.must_change "Orderitem.count", -2

      find_destroyed_order = Order.find_by(id: my_order.id)
      expect(find_destroyed_order).must_equal nil
    end
  end

  # we might want to test validations for Orders here
end
