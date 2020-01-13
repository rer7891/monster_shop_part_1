class AddSavingsToUserCoupons < ActiveRecord::Migration[5.1]
  def change
    add_column :user_coupons, :savings, :integer
  end
end
