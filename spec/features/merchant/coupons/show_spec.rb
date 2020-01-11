require 'rails_helper'

RSpec.describe "As a merchant", type: :feature do
  before :each do
    @merchant = create(:jomah_merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant)
    @user = create(:random_user)
    @user_2 = create(:random_user)
    @coupon_1 = create(:random_coupon, merchant: @merchant)
    @order_1 = create(:random_order, user: @user, coupon: @coupon_1)
    @order_2 = create(:random_order, user: @user, coupon: @coupon_1)
    @order_3 = create(:random_order, user: @user_2, coupon: @coupon_1)

    @user.coupons << @coupon_1
    @user_2.coupons << @coupon_1

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
    visit merchant_dash_coupon_path(@coupon_1)
  end
  it "a merchant can see a list of any active coupons with all details" do

  end
  it "can click on a link to see all coupons including inactive" do

  end
end
