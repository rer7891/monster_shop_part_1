require 'rails_helper'

RSpec.describe "As a merchant", type: :feature do
  it "can delete a coupon" do
    merchant = create(:jomah_merchant)
    merchant_employee = create(:merchant_employee, merchant: merchant)
    coupon = create(:random_coupon, merchant: merchant)
    coupon_2 = create(:random_coupon, merchant: merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)
    visit merchant_dash_coupons_path

    expect(Coupon.count).to eq(2)
    within "#coupon-#{coupon.id}" do
      click_on "Delete Coupon"
      expect(current_path).to eq(merchant_dash_coupons_path)
    end
    expect(Coupon.count).to eq(1)

    within "#coupon-#{coupon_2.id}" do
      expect(page).to have_content(coupon_2.name)
    end

    expect(page).to_not have_content(coupon.name)
  end
end
