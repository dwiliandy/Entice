class RemoveNotNullFromTransactionDetail < ActiveRecord::Migration[6.1]
  def change
    change_column :transaction_details, :address, :string, :null => true
    change_column :transaction_details, :city, :string, :null => true
    change_column :transaction_details, :phone_number, :string, :null => true
    change_column :transaction_details, :postcode, :string, :null => true
    change_column :transaction_details, :recipient_name, :string, :null => true
  end
end
