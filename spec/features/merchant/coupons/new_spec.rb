require 'rails_helper'

RSpec.describe "As a merchant employee", type: :feature do
  before :each do
    @merchant = create(:jomah_merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
    visit merchant_dash_coupons_path
  end

  it "can add a new coupon" do
    click_link "Add A Coupon"
    expect(current_path).to eq(new_merchant_dash_coupon_path)
    expect(Coupon.count).to eq(0)

    fill_in "Name", with: "4th of July Sale"
    fill_in "Code", with: "XRT45Q"
    fill_in "Percent", with: 0.45
    click_on "Create Coupon"

    expect(Coupon.count).to eq(1)
    new_coupon = Coupon.last
    expect(new_coupon.name).to eq("4th of July Sale")
    expect(new_coupon.percent).to eq(0.45)
    expect(page).to have_content("You added a new coupon.")
  end

  it "can only have 5 active coupons" do
    coupon_x = create(:random_coupon, merchant: @merchant)
    coupon_7 = create(:random_coupon, merchant: @merchant)
    coupon_t = create(:random_coupon, merchant: @merchant)
    coupon_j = create(:random_coupon, merchant: @merchant)
    coupon_q = create(:random_coupon, merchant: @merchant)

    visit merchant_dash_coupons_path
    click_link "Add A Coupon"

    expect(current_path).to eq(merchant_dash_coupons_path)
    expect(page).to have_content("Deactivate a coupon if you wish to add more.")
  end
end
