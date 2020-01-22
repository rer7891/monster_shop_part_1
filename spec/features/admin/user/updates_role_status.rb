require 'rails_helper'

RSpec.describe "As an admin", type: :feature do
  it "can update any users role" do
    admin = create(:admin_user)
    user = create(:random_user)
    user_2 = create(:random_user)
    user_3 = create(:random_user)
    merchant = create(:ray_merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dash_users_path

    expect(user.role).to eq("user")

    within "#user-#{user.id}" do
      expect(page).to have_content('Role')
      select "merchant_employee", :from => "Role"
      select("Vintage Vampire", from: "Merchant").select_option
      click_on "Update"
    end

    user.reload
    expect(user.role).to eq("merchant_employee")
    expect(user.merchant_id).to eq(merchant.id)
    expect(page).to have_content("The user role has been updated to #{user.role}.")
  end

  it "won't update a merchant id if its not a merchant employee" do
    admin = create(:admin_user)
    user = create(:merchant_employee)
    merchant = create(:ray_merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dash_users_path

    expect(user.role).to eq("merchant_employee")

    within "#user-#{user.id}" do
      select "user", :from => "Role"
      select("Vintage Vampire", from: "Merchant").select_option
      click_on "Update"
    end

    user.reload
    expect(user.role).to eq("user")
    expect(user.merchant_id).to eq(nil)
    expect(page).to have_content("The user role has been updated to #{user.role}.")
  end
end
