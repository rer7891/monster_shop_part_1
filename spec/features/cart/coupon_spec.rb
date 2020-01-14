require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  before :each do
  @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
  @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

  @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 135, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  @seat = @meg.items.create(name: "Leather Seat", description: "They'll never wear out", price: 300, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 16)
  @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 200, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
  @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 235, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

  @coupon_1 = create(:random_coupon, percent: 0.43, merchant: @meg)
  @coupon_2 = create(:random_coupon, percent: 0.25, merchant: @meg)

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

  it "I can enter a coupon for my order" do
    fill_in "Code", with: @coupon_1.code
    click_button "Create Coupon"
  end

  it "when I enter a coupon it only discounts the items from that merchant" do
    fill_in "Code", with: @coupon_1.code
    click_button "Create Coupon"

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content("$1.35")
      expect(page).to have_content("$0.77")
    end
    within "#cart-item-#{@seat.id}" do
      expect(page).to have_content("$3.00")
      expect(page).to have_content("$1.71")
    end
    within "#cart-item-#{@pencil.id}" do
      expect(page).to have_content("2.35")
      expect(page).to_not have_content("$1.34")
    end
    within "#cart-item-#{@paper.id}" do
      expect(page).to have_content("$2.00")
      expect(page).to_not have_content("$1.14")
    end

  end

  it "I can continue shopping after entering code and coupon will be there when I return" do
    tofu = @meg.items.create(name: "Tofu", description: "You can eat it.", price: 200, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 60)
    visit "/cart"

    fill_in "Code", with: @coupon_1.code
    click_button "Create Coupon"

    visit "/items/#{tofu.id}"
    click_on "Add To Cart"

    visit "/cart"
    within "#cart-item-#{tofu.id}" do
      expect(page).to have_content("$2.00")
      expect(page).to have_content("$1.14")
    end

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content("$1.35")
      expect(page).to have_content("$0.77")
    end
  end

  it "I will see calculated subtotals and the grand total as usual, also a discounted total" do
    fill_in "Code", with: @coupon_1.code
    click_button "Create Coupon"

    expect(page).to have_content("Total: $8.70")
    expect(page).to have_content("Discounted Total $6.83")

  end

  it "when I enter an additional coupon on that order it replaces the old one" do
    fill_in "Code", with: @coupon_2.code
    click_button "Create Coupon"

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content("$1.35")
      expect(page).to have_content("$1.01")
    end
    within "#cart-item-#{@seat.id}" do
      expect(page).to have_content("$3.00")
      expect(page).to have_content("$2.25")
    end
  end
end
