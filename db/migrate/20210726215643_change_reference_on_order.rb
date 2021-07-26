class ChangeReferenceOnOrder < ActiveRecord::Migration[6.1]
  def up
  	remove_reference :orders, :postal_fee
  	add_reference :orders, :service_charge
  end

  def down
  	remove_reference :orders, :service_charge
  	add_reference :orders, :postal_fee
  end
end
