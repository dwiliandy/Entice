class AddColumnToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :receiver, :string
    add_column :transactions, :receipt_number, :string
  end
end
