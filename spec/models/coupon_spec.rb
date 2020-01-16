require 'rails_helper'

describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_numericality_of :percent }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :user_coupons}
    it {should have_many(:users).through(:user_coupons)}
  end

  describe "methods" do
      it "should be able to count coupon uses by user" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      coupon_1 = create(:random_coupon, percent: 0.43, merchant: meg)

      user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      user.user_coupons.create(coupon: coupon_1)

      expect(coupon_1.uses(user)).to eq(1)
    end
  end
end
