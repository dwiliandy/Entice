class CreateCommentReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_replies do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
