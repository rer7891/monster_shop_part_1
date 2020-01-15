require 'rails_helper'

RSpec.describe "As a merchant", type: :feature do
  before :each do
    @merchant = create(:jomah_merchant)
    @ray = create(:ray_merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant)
    @coupon_1 = create(:random_coupon, code: "AFRE32", merchant: @merchant)
    @coupon_2 = create(:random_coupon, code: "ADFADF364", merchant: @merchant)
    @coupon_3 = create(:random_coupon, code: "ADF43", merchant: @merchant)
    @coupon_4 = create(:random_coupon, code: "ADFAE211", merchant: @ray)
    @coupon_5 = create(:random_coupon, code: "AFAD54", active: false, merchant: @merchant)
    @coupons = [@coupon_1, @coupon_2, @coupon_3]

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
    visit merchant_dash_coupons_path
  end
  it "a merchant can see a list of any active coupons with all details" do
    @coupons.each do |coupon|
      within "#coupon-#{coupon.id}" do
        expect(page).to have_link(coupon.name)
        expect(page).to have_content(coupon.code)
        expect(page).to have_content(coupon.percent * 100)
        expect(page).to have_content(coupon.used?)
      end
    end
      expect(page).not_to have_link(@coupon_4.name)
      expect(page).not_to have_content(@coupon_4.code)
      expect(page).not_to have_link(@coupon_5.name)
      expect(page).not_to have_content(@coupon_5.code)
  end
  it "can click on a link to see all coupons including inactive" do

    click_link "List All Coupons Including Inactive Coupons"
    expect(current_path).to eq(merchant_dash_coupons_path)

    within "#coupon-#{@coupon_5.id}" do
      expect(page).to have_link(@coupon_5.name)
      expect(page).to have_content(@coupon_5.code)
      expect(page).to have_content(@coupon_5.percent * 100)
      expect(page).to have_content(@coupon_5.used?)
    end
    expect(page).not_to have_link(@coupon_4.name)
    expect(page).not_to have_content(@coupon_4.code)
  end
  it "can disable a coupon" do
    expect(@coupon_1.active).to eq(true)
    within "#coupon-#{@coupon_1.id}" do
      expect(page).to have_link("Disable Coupon")
      click_link "Disable Coupon"
      expect(current_path).to eq(merchant_dash_coupons_path)
    end
    expect(page).not_to have_link(@coupon_1.name)
    @coupon_1.reload
    expect(@coupon_1.active).to eq(false)
  end
end
