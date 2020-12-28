class CreatePostalFees < ActiveRecord::Migration[6.0]
  def change
    create_table :postal_fees do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
