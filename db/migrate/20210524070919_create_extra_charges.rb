class CreateExtraCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :extra_charges do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
