class AddOrderToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :order, foreign_key: true
  end
end
