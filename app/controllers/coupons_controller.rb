class CouponsController < ApplicationController
  def create
    session[:coupon] = params["coupon"]["code"]
    @coupon = session[:coupon]
    redirect_to cart_path
  end
  
end
