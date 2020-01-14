class RemoveOrdersFromUserCoupons < ActiveRecord::Migration[5.1]
  def change
    remove_reference :user_coupons, :order, foreign_key: true
  end
end
