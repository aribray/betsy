# frozen_string_literal: true

require 'test_helper'
require 'pry'

describe User do
  let(:user) { users(:dee) }

  describe 'validations' do
    it 'must be valid' do
      value(user).must_be :valid?
    end

    describe 'username' do
      it 'requires a username' do
        user = User.new
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :username
      end

      it 'username must be unique' do
        new_user = User.new(username: 'kool')
        expect(new_user.save).must_equal false
        expect(new_user.errors.messages).must_include :username
      end
    end

    describe 'email' do
      it 'requires a email' do
        user = User.new
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :email
      end

      it 'email must be unique' do
        new_user = User.new(email: 'kool@kids.org')
        expect(new_user.save).must_equal false
        expect(new_user.errors.messages).must_include :email
      end
    end

    describe 'uid' do
      it 'requires a uid' do
        user = User.new
        expect(user.valid?).must_equal false
        expect(user.errors.messages).must_include :uid
      end

      it 'uid must be unique' do
        new_user = User.new(uid: 1)
        expect(new_user.save).must_equal false
        expect(new_user.errors.messages).must_include :uid
      end
    end

    it 'requires a provider' do
      user = User.new
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :provider
    end
  end

  describe 'relations' do
    it 'has many products' do
      user.must_respond_to :products
      user.products.each do |product|
        product.must_be_kind_of Product
      end
    end

    it 'has many orderitems' do
      user.must_respond_to :orderitems
      user.orderitems.each do |item|
        item.must_be_kind_of Orderitem
      end
    end
  end

  describe "build_from_github" do
    
  end
end
