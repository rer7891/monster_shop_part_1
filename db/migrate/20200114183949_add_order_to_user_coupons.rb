class AddOrderToUserCoupons < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_coupons, :order, foreign_key: true
  end
end
