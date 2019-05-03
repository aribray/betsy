# frozen_string_literal: true

class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :orderitems, through: :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.name = auth_hash["info"]["name"]
    user.username = auth_hash["info"]["nickname"]
    user.email = auth_hash["info"]["email"]

    return user
  end
end
