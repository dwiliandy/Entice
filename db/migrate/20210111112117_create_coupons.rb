class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.boolean :disable, default: false
      t.integer :qty
      t.integer :variety
      t.integer :discount

      t.timestamps
    end
  end
end
