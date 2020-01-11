require 'rails_helper'

RSpec.describe "As a merchant", type: :feature do
  before :each do
    @merchant_employee = create(:merchant_employee)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
  end
  it "Merchant users have a link on their dashboard to manage their coupons." do
    visit merchant_dash_path

    expect(page).to have_link("Manage Coupons")
    click_link "Manage Coupons"
    expect(current_path).to eq(merchant_dash_coupons_path)
  end
end
