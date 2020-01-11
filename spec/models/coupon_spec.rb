require 'rails_helper'

describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_presence_of :percent }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :user_coupons}
    it {should have_many(:users).through(:user_coupons)}
  end
end
