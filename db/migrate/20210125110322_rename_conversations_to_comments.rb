class RenameConversationsToComments < ActiveRecord::Migration[6.1]
  def up
  	rename_table :conversations, :comments
  end

  def down
  	rename_table :comments, :conversations
  end
end
