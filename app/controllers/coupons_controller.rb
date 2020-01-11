class CouponsController < ApplicationController
  def create
    session[:coupon] = params["coupon"]["code"]
    redirect_to cart_path
  end

  def find_saving
  end
end
