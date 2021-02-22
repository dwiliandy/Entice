class CreateWalletStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :wallet_statuses do |t|
      t.float :nominal
      t.string :proof_of_payment
      t.string :status
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
