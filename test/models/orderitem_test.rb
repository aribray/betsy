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

    it "must have a number quantity greater than 0" do
      orderitem.quantity = -1
      valid_orderitem = orderitem.valid?

      expect(valid_orderitem).must_equal false
      expect(orderitem.errors.messages).must_include :quantity
      expect(orderitem.errors.messages[:quantity]).must_equal ["must be greater than 0"]
    end
  end
end
