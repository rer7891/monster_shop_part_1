class RemoveSavingsFromUserCoupons < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_coupons, :savings, :integer
  end
end
