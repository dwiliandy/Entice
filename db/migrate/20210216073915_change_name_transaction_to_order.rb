class ChangeNameTransactionToOrder < ActiveRecord::Migration[6.1]
 def up
  	rename_table :transactions, :orders
  end

  def down
  	rename_table :orders, :transactions
  end
end
