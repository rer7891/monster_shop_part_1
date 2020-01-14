class User::OrdersController < User::BaseController

  def new
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    @coupon = Coupon.where(code: session[:coupon]).first
    order = current_user.orders.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price,
          discount_price: cart.discount(item, @coupon)
          })
      order_update
    end
      flash[:notice] = "Order Placed"
      redirect_to profile_orders_path
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def index
    @orders = current_user.orders
  end

  def cancel
    @order = current_user.orders.find(params[:id])
    @order.cancel
    flash[:notice] = "Order Cancelled"
    redirect_to profile_path
  end

private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def order_update
    current_user.coupons << @coupon if @coupon
    @coupon.toggle!(:used?) if @coupon && !@coupon.used?
    session.delete(:cart)
    session.delete(:coupon)
  end
end
