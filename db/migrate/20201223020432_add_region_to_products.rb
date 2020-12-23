class AddRegionToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :region
  end
end
