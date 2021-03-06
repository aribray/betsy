# frozen_string_literal: true

require "test_helper"

describe User do
  let(:user) { users(:dee) }

  describe "validations" do
    it "must be valid" do
      value(user).must_be :valid?
    end

    describe "username" do
      it "requires a username" do
        user = User.new
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :username
      end

      it "username must be unique" do
        new_user = User.new(username: "kool")
        expect(new_user.save).must_equal false
        expect(new_user.errors.messages).must_include :username
      end
    end

    describe "email" do
      it "requires a email" do
        user = User.new
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :email
      end

      it "email must be unique" do
        new_user = User.new(email: "kool@kids.org")
        expect(new_user.save).must_equal false
        expect(new_user.errors.messages).must_include :email
      end
    end

    describe "uid" do
      it "requires a uid" do
        user = User.new
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :uid
      end

      it "uid must be unique" do
        new_user = User.new(uid: 1)
        expect(new_user.save).must_equal false
        expect(new_user.errors.messages).must_include :uid
      end
    end

    it "requires a provider" do
      user = User.new
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :provider
    end
  end

  describe "relations" do
    it "has many products" do
      user.must_respond_to :products
      user.products.each do |product|
        product.must_be_kind_of Product
      end
    end

    it "has many orderitems" do
      user.must_respond_to :orderitems
      user.orderitems.each do |item|
        item.must_be_kind_of Orderitem
      end
    end
  end

  describe "total revenue" do
    it "returns an integer" do
      total = User.total_revenue(user)
      expect(total).must_be_kind_of Money
    end

    it "returns total revenue of all orderitems as default" do
      total = User.total_revenue(user)
      expect(total.cents).must_equal 188
    end

    it "returns the total revenue of a passed in parameter" do
      item = user.orderitems.first
      item.shipped = "true"
      item.save
      total = User.total_revenue(user, shipped: "true")
      expect(total.cents).must_equal 10

      total = User.total_revenue(user, shipped: "false")
      expect(total.cents).must_equal 178
    end
  end

  describe "build_from_github" do
    before do
      @auth_hash = {
        provider: user.provider,
        uid: user.uid,
        "info" => {
          "email" => user.email,
          "nickname" => user.username,
          "name" => user.name,
        },
      }
    end
    it "can populate the hash fields" do
      new_user = User.build_from_github(@auth_hash)

      expect(new_user.uid).must_equal @auth_hash[:uid]
      expect(new_user.provider).must_equal @auth_hash[:provider]
      expect(new_user.email).must_equal @auth_hash["info"]["email"]
      expect(new_user.name).must_equal @auth_hash["info"]["name"]
      expect(new_user.username).must_equal @auth_hash["info"]["nickname"]
    end
  end
end
