class DropOrderStatus < ActiveRecord::Migration[6.1]
  def up
  	unless column_exists? :transactions, :status
  		add_column :transactions, :status, :string
  	end

  	if column_exists? :transactions, :order_status_id
      remove_column	 :transactions, :order_status_id
  	end
      drop_table :order_statuses
  end

  def down
  	unless OrderStatus.table_exists?
	    create_table :order_statuses do |t|
	      t.string :name

	      t.timestamps
	    end
	end

	unless column_exists? :transactions, :order_status_id
    	add_reference :transactions, :order_status, foreign_key: true
    end

    if column_exists? :transactions,:status
    	remove_column :transactions, :status
    end
  end
end
