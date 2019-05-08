require "test_helper"

describe Orderitem do
  let(:orderitem) { orderitems(:three) }

  describe "validations" do
    it "must contain quantity as a number" do
      orderitem.quantity = nil
      valid_orderitem = orderitem.valid?

      expect(valid_orderitem).must_equal false
      expect(orderitem.errors.messages).must_include :quantity
      expect(orderitem.errors.messages[:quantity]).must_equal ["is not a number"]
    end

    it "must have a quantity greater than 0" do
      orderitem.quantity = -1
      valid_orderitem = orderitem.valid?

      expect(valid_orderitem).must_equal false
      expect(orderitem.errors.messages).must_include :quantity
      expect(orderitem.errors.messages[:quantity]).must_equal ["must be greater than 0"]
    end
  end

  describe "relationships" do
    let (:product) {
      products(:turtleneck)
    }

    let (:order) {
      orders(:one)
    }

    it "belongs to product" do
      orderitem.product = product

      expect(orderitem.product_id).must_equal product.id
      expect(orderitem).must_respond_to :product
    end

    it "belongs to order" do
      orderitem.order = order

      expect(orderitem.order_id).must_equal order.id
      expect(orderitem).must_respond_to :order
    end

    it "will not change the product count when destroyed" do
      my_orderitem = orderitem

      expect {
        my_orderitem.destroy
      }.wont_change "Product.count"
    end

    it "will not change the order count when destroyed" do
      my_orderitem = orderitem

      expect {
        my_orderitem.destroy
      }.wont_change "Order.count"
    end
  end
end
