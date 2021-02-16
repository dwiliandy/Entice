class AddNoteToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :note, :text
  end
end
