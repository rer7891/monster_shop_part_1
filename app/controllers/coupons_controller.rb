class CouponsController < ApplicationController
  def create
    coupon = Coupon.where(code: params["coupon"]["code"]).first
      if current_user.id != nil && coupon.uses(current_user) < 1
      session[:coupon] = params["coupon"]["code"]
      coupon = session[:coupon]
    else
      flash[:error] = "Please log in to use this coupon or check that the coupon has not already been used."
    end
    redirect_to cart_path
  end
end
