# == Schema Information
#
# Table name: transactions
#
#  id            :bigint           not null, primary key
#  status        :string
#  total_price   :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cart_id       :bigint
#  postal_fee_id :bigint           not null
#
# Indexes
#
#  index_transactions_on_cart_id        (cart_id)
#  index_transactions_on_postal_fee_id  (postal_fee_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (postal_fee_id => postal_fees.id)
#
class Transaction < ApplicationRecord
  belongs_to :postal_fee
  belongs_to :order_status
  belongs_to :cart, dependent: :destroy


asm column: :status do
    state :active, initial: true
    state :processed, :delivery, :delivered, :finished, :cancelled, :reviewed

    event :verified do
      transitions from: :active, to: :processed
    end

    event :ongoing do
      transitions from: :processed, to: :delivery
    end

    event :arrived do
      transitions from: :delivery, to: :delivered
    end

    event :completion do
      transitions from: :delivered, to: :finished
    end

    event :canceling do
    	transitions from: :active, to: :cancelled
    end

    event :review do
    	transitions from: :finished, to: :reviewed
    end
  end
  
  class <<self 
  	def final_price
  		total_price = cart.price + postal_fee.price
  	end
  end
end
