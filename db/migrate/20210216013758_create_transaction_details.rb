class CreateTransactionDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_details do |t|
      t.string :recipient_name, null: false
      t.text :address, null: false
      t.text :address_detail
      t.string :city, null: false
      t.string :postcode, null: false
      t.string :phone_number, null: false
      t.references :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
