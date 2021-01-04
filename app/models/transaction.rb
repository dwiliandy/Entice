# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  total_price     :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cart_id         :bigint
#  order_status_id :bigint           not null
#  postal_fee_id   :bigint           not null
#
# Indexes
#
#  index_transactions_on_cart_id          (cart_id)
#  index_transactions_on_order_status_id  (order_status_id)
#  index_transactions_on_postal_fee_id    (postal_fee_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (postal_fee_id => postal_fees.id)
#
class Transaction < ApplicationRecord
  belongs_to :postal_fee
  belongs_to :order_status
  belongs_to :cart, dependent: :destroy


  class <<self 
  	def final_price
  		total_price = cart.price + postal_fee.price
  	end
  end
end
