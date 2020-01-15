class Coupon < ApplicationRecord
  default_scope { where(active: true) }


  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :percent, numericality: {less_than_or_equal_to: 0.99}

  belongs_to :merchant

  has_many :user_coupons, dependent: :destroy
  has_many :users, through: :user_coupons
end
