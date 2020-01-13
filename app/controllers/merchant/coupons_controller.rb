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

  def new
    merchant = current_user.merchant
    coupon_count = merchant.coupons.where(active: true).count
    if coupon_count <= 4
      @coupon = Coupon.new
    else
      flash[:error] = "Deactivate a coupon if you wish to add more."
      redirect_to merchant_dash_coupons_path
    end
  end

  def create
    merchant = current_user.merchant
    coupon = merchant.coupons.new(coupon_params)
    if coupon.save
      flash[:success] = "You added a new coupon."
      redirect_to merchant_dash_coupons_path
    else
      generate_error(coupon)
      render :new
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :percent)
  end
end
