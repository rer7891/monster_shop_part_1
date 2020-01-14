require 'rails_helper'

RSpec.describe "As a merchant", type: :feature do
  it "can edit a coupon" do
    merchant = create(:jomah_merchant)
    merchant_employee = create(:merchant_employee, merchant: merchant)
    coupon = create(:random_coupon, merchant: merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)
    visit merchant_dash_coupons_path

    click_on "Edit Coupon"
    expect(current_path).to eq(edit_merchant_dash_coupon_path(coupon))

    expect(find_field('Name').value).to eq coupon.name
    expect(find_field('Code').value).to eq coupon.code
    expect(find_field('Percent').value).to eq coupon.percent.to_s


    fill_in "Name", with: "New Coupon Name"
    fill_in "Code", with: "SUBTRACT25"

    click_on "Update Coupon"

    coupon.reload
    expect(current_path).to eq(merchant_dash_coupons_path)
    expect(page).to have_content("You have updated your coupon.")
    expect(coupon.name).to eq("New Coupon Name")

  end
end
