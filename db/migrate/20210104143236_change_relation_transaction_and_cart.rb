class ChangeRelationTransactionAndCart < ActiveRecord::Migration[6.1]
  def self.down
    change_table :carts do |t|
      t.remove :transaction_id
    end
    unless column_exists? :transactions, :cart_id
  		add_column :transactions, :cart_id, foreign_key: true
	end
  end
end
