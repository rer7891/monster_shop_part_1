require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  before :each do
  @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
  @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

  @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  @seat = @meg.items.create(name: "Leather Seat", description: "They'll never wear out", price: 300, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 16)
  @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
  @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
  @coupon_1 = create(:random_coupon, merchant: @meg)

  visit "/items/#{@paper.id}"
  click_on "Add To Cart"
  visit "/items/#{@tire.id}"
  click_on "Add To Cart"
  visit "/items/#{@pencil.id}"
  click_on "Add To Cart"
  visit "/items/#{@seat.id}"
  click_on "Add To Cart"
  visit cart_path
  end

  it "I see a spot to enter a coupon for my order" do
    #expect(page).to have_css('input[type="Coupon Code"]')
    fill_in "Code", with: @coupon_1.code
    click_button "Create Coupon"
  end

  it "when I enter a coupon it only discounts the items from that merchant" do
  end

  it "I can continue shopping after entering code and coupon will be there when I return" do
  end

  it "I will see calculated subtotals and the grand total as usual, also a discounted total" do
  end

  it "when I enter an additional coupon on that order it replaces the old one" do
  end
end
