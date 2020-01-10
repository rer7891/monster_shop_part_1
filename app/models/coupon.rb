class Coupon < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates_inclusion_of :used?, in: [true, false]
  validates_inclusion_of :percent, in: 0..100

  belongs_to :merchant

  has_many :user_coupons, dependent: :destroy
  has_many :users, through: :user_coupons
end
