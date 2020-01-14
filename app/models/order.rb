class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, numericality: { only_integer: true, message: "must be a number" }

  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders
  belongs_to :user
  belongs_to :coupon, optional: true

  enum status: %w(packaged pending shipped cancelled)

  def grandtotal
    item_orders.sum('price * quantity').round(2)
  end

  def discounted_grand_total
    discounted = item_orders.where("discount_price != 0")
    discount = discounted.sum('discount_price * quantity')

    non_discounted = item_orders.where("discount_price = 0")
    price = non_discounted.sum('price/100 * quantity')

    total = (discount += price).round(2)
  end

  def savings
    savings = ((grandtotal/100) - discounted_grand_total).round(2)
  end

  def cancel
    update(status: "cancelled")
    item_orders.each do |item_order|
      item_order.update(status: "unfulfilled")
      item_order.item.update(inventory: item_order.item.inventory + item_order.quantity)
    end
  end

  def package_if_fulfilled
    update(status: "packaged") if item_orders.distinct.pluck(:status) == ["fulfilled"]
  end

  def quantity_ordered
    item_orders.sum(:quantity)
  end

  def quantity_ordered_from(merchant)
    items.where(merchant: merchant).sum("item_orders.quantity")
  end

  def subtotal_from(merchant)
    items.joins(:item_orders).where(merchant: merchant).sum("item_orders.price * item_orders.quantity")
  end

  def self.sort_by_status
    order(status: :ASC)
  end
end
