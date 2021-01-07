class FixChangeRelationTransactionAndCart < ActiveRecord::Migration[6.1]
  def up
  	if column_exists? :carts, :transaction_id
	  	remove_column :carts, :transaction_id
	end
	unless column_exists? :transactions, :cart_id
	  	add_reference :transactions, :cart, foreign_key: true
	end
  end

  def down
  	if column_exists? :transactions, :cart_id
  		remove_column :transactions, :cart_id, foreign_key: true
  	end
  	unless column_exists? :carts, :transaction_id
  		add_reference :carts, :transaction, foreign_key: true
  	end
  end
end
