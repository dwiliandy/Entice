class RemoveStockFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :stock
  end
end
