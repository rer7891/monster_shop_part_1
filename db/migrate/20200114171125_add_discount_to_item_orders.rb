class AddDiscountToItemOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :item_orders, :discount_price, :float
  end
end
