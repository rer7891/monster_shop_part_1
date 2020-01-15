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
    @merchant = current_user.merchant
    @coupon = @merchant.coupons.new(coupon_params)
    @coupon.percent = (params[:coupon][:percent].to_f / 100)
    if @coupon.save
      flash[:success] = "You added a new coupon."
      redirect_to merchant_dash_coupons_path
    else
      if @coupon.percent > 0.99
        flash[:error] = "Coupons cannot be more than 100% off."
      else
        generate_error(@coupon)
      end
    render :new
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    @coupon.update(coupon_params)
    if @coupon.save
      flash[:success] = "You have updated your coupon."
      redirect_to merchant_dash_coupons_path
    else
      generate_error(@coupon)
      render :edit
    end
  end

  def destroy
    coupon = Coupon.find(params[:id])
    if coupon.used? == false
       coupon.destroy
      flash[:success] = "Coupon Deleted"
    else
     flash[:error] = "You cannot delete this coupon."
    end
    redirect_to merchant_dash_coupons_path
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :percent, :active)
  end
end
