class ChangeReferencesTransactionToCart < ActiveRecord::Migration[6.1]
  def self.down
    change_table :carts do |t|
      t.remove :transaction_id
    end
  end
  def self.up
    change_table :transactions do |t|
      t.references :cart, foreign_key: true
    end
  end
end
