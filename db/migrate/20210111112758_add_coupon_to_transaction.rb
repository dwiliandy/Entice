class AddCouponToTransaction < ActiveRecord::Migration[6.1]
  def up
    add_reference :transactions, :coupon, foreign_key: true
  end

  def down
  	remove_column :transactions, :coupon_id
  end
end
