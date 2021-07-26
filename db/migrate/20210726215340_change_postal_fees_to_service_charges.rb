class ChangePostalFeesToServiceCharges < ActiveRecord::Migration[6.1]
  def up
  	rename_table :postal_fees, :service_charges
  end

  def down
  	rename_table :ervice_charges, :postal_fees
  end
end
