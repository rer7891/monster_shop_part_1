class AddfloatToCoupons < ActiveRecord::Migration[5.1]
  def change
    remove_column :coupons, :percent, :integer
    add_column :coupons, :percent, :float
  end
end
