class UserCoupon <ApplicationRecord
  validates_presence_of :coupon_id, :user_id

  belongs_to :user
  belongs_to :coupon
end
