require 'rails_helper'

RSpec.describe UserCoupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :coupn_id }
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should belong_to :coupon}
    it {should belong_to :order}
  end
