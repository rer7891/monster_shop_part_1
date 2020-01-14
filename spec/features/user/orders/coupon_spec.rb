require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  before :each do
    @user = create(:random_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 250, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 210, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @coupon_1 = create(:random_coupon, percent: 0.43, merchant: @mike)

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"

    visit "/cart"
    fill_in "Code", with: @coupon_1.code
    click_button "Create Coupon"
    click_on "Checkout"
    click_on "Create Order"

    fill_in :name, with: @user.name
    fill_in :address, with: @user.address
    fill_in :city, with: @user.city
    fill_in :state, with: @user.state
    fill_in :zip, with: @user.zip
  end

  it "can attach a discount to an order" do
    #once a coupon is used it's status is updated
    expect(@coupon_1.used?).to eq(false)

    click_button "Create Order"

    @coupon_1.reload
    expect(@coupon_1.used?).to eq(true)

    order = Order.last
    expect(order.coupon).to eq(@coupon_1)

    #can show discounted order totals and savings"
      expect(order.discounted_grand_total).to eq(3.63)
      expect(order.savings).to eq(1.97)
  end
end
