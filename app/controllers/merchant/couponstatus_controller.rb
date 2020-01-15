class Merchant::CouponstatusController < ApplicationController
  def update
    coupon = Coupon.unscoped.find(params[:coupon_id])
    coupon_count = Coupon.count
    if !coupon.active? && coupon_count <= 5 || coupon.active?
      coupon.toggle!(:active)
      redirect_to merchant_dash_coupons_path
      if coupon.active?
        flash[:success] = "#{coupon.name} is active."
      else
        flash[:success] = "#{coupon.name} is no longer active."
      end
    else
      flash[:error] = "You must delete or disable another coupon to enable more."
    end
  end

end
