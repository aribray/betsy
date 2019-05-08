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

  describe "subtotal" do
    it "returns the total of all of the orderitems in this order" do
      my_order = order

      sum = 0
      my_order.orderitems.each do |item|
        sum += item.product.price * item.quantity
      end

      my_order.subtotal.must_be_kind_of Money
      my_order.subtotal.must_equal sum
    end
  end

  describe "taxes" do
    it "calculates taxes for the order subtotal" do
      my_order = order

      sum = 0
      my_order.orderitems.each do |item|
        sum += item.product.price * item.quantity
      end

      desired_output = sum * 0.101

      my_order.taxes.must_equal desired_output
    end
  end

  describe "total" do
    it "calulates the sum plus tax for an order" do
      my_order = order
      sum = 0
      my_order.orderitems.each do |item|
        sum += item.product.price * item.quantity
      end
      sum *= (1 + 0.101)

      my_order.total.must_be_kind_of Money
      my_order.total.must_equal sum
    end
  end

  # we might want to test validations for Orders here
end
