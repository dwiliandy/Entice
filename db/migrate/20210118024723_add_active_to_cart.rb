class AddActiveToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :active, :bool
  end
end
