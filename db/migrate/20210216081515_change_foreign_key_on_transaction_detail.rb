class ChangeForeignKeyOnTransactionDetail < ActiveRecord::Migration[6.1]
  def up
  	remove_reference :transaction_details, :transaction
  	add_reference :transaction_details, :order
  end

  def down
  	remove_reference :transaction_details, :order
  	add_reference :transaction_details, :transaction
  end
end
