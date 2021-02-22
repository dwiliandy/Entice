# == Schema Information
#
# Table name: orders
#
#  id             :bigint           not null, primary key
#  note           :text
#  receipt_number :string           default("-")
#  receiver       :string           default("-")
#  status         :string
#  total_price    :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cart_id        :bigint
#  coupon_id      :bigint
#  postal_fee_id  :bigint           not null
#
# Indexes
#
#  index_orders_on_cart_id        (cart_id)
#  index_orders_on_coupon_id      (coupon_id)
#  index_orders_on_postal_fee_id  (postal_fee_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (coupon_id => coupons.id)
#  fk_rails_...  (postal_fee_id => postal_fees.id)
#
class Order < ApplicationRecord
	include AASM

  aasm column: :status do
    
    state :pending, initial: true
    state :active, :processed, :delivery, :delivered, :finished, :cancelled, :reviewed

    event :verified do
      transitions from: :pending, to: :active
    end

    event :processing do
      transitions from: :active, to: :processed
    end

    event :deliver do
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

STATUS_OPTIONS = [
  ["Pending", :pending],
    ["Active", :active],
    ["Processed", :processed],
    ["Delivery", :delivery],
    ["Delivered", :delivered],
    ["Finished", :finished],
    ["Cancelled", :cancelled]
  ]

  scope :status_pending, -> { where(status: "pending") }
  scope :status_ongoing, -> { where(status: ["active", "processed", "delivery", "delivered"]) }
  scope :status_completed, -> { where(status: ["finished", "cancelled"]) }

  belongs_to :postal_fee
  belongs_to :cart, dependent: :destroy
  has_one :transaction_detail
  accepts_nested_attributes_for :transaction_detail
  # after_create :retracted_from_wallet
    after_create :final_price
  belongs_to :coupon, optional: true
  

  # def retracted_from_wallet
  #   current_user = self.cart.user

  #   wallet = Wallet.find_by(user_id: current_user.id)

  #   wallet.update(nominal: wallet.nominal - self.total_price)
  # end
  
    def check_discount
      coupon = self.coupon
      if coupon.present?
        if coupon.postal?
          disc = cart.price * (coupon.discount/100.to_f)
        else
          disc = postal_fee.price * (coupon.discount/100.to_f)
        end
      end
    end


  	def final_price
      total_price = cart.price + postal_fee.price
      total_price = total_price - self.check_discount
      self.update(total_price: total_price)
    end    


end