class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.float :total_price
      t.references :order_status, null: false, foreign_key: true
      t.references :postal_fee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
