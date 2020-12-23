class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :description
      t.string :name
      t.string :image
      t.float :price
      t.integer :status
      t.integer :stock

      t.timestamps
    end
  end
end
