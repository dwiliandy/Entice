# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  message    :text
#  read       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint
#  user_id    :bigint           not null
#
# Indexes
#
#  index_notifications_on_order_id  (order_id)
#  index_notifications_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
end
