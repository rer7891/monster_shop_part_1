class Merchant::CouponsController <  Merchant::BaseController
  def index
    if params[:sort] == "active_status"
      @coupons = Coupon.unscoped.where(merchant_id: current_user.merchant.id)
    else
      @coupons = Coupon.where(merchant_id: current_user.merchant.id)
    end
  end

  def show
    @coupon = Coupon.find(params[:id])
  end
end
