class AddDefaultValueToTransactionColumn < ActiveRecord::Migration[6.1]
  def change
  	change_column_default :transactions, :receiver, '-'
  	change_column_default :transactions, :receipt_number, '-'
  end
end
