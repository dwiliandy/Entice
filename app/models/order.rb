# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  note              :text
#  receipt_number    :string           default("-")
#  receiver          :string           default("-")
#  status            :string
#  total_price       :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  cart_id           :bigint
#  coupon_id         :bigint
#  service_charge_id :bigint
#
# Indexes
#
#  index_orders_on_cart_id            (cart_id)
#  index_orders_on_coupon_id          (coupon_id)
#  index_orders_on_service_charge_id  (service_charge_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (coupon_id => coupons.id)
#
class Order < ApplicationRecord
	include AASM

  belongs_to :service_charge
  belongs_to :cart, dependent: :destroy
  belongs_to :coupon, optional: true
  has_one :transaction_detail
  accepts_nested_attributes_for :transaction_detail
  after_create :final_price
  # has_many :notifications

  aasm column: :status do
    
    state :pending, initial: true
    state :active, :processed, :delivery, :delivered,:delivered_confirmed, :finished, :cancelled, :reviewed

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

    event :confirmation do
      transitions from: :delivered, to: :delivered_confirmed
    end

    event :completion do
      transitions from: :delivered_confirmed, to: :finished
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
    ["Delivered Confirmed", :delivered_confirmed],
    ["Finished", :finished],
    ["Cancelled", :cancelled]
  ]

  scope :status_pending, -> { where(status: "pending") }
  scope :status_ongoing, -> { where(status: ["active", "processed", "delivery", "delivered"]) }
  scope :status_completed, -> { where(status: ["finished", "cancelled"]) }


    def check_discount
      coupon = self.coupon
      if coupon.present?
        if coupon.service_charge?
          disc = cart.price * (coupon.discount/100.to_f)
        else
          disc = service_charge.price
        end
      end
    end

    def check_extra_charge
      extra_charge_check = self.cart.products.pluck(:status)

      if extra_charge_check.include? "not_ready"
        extra_charge = ExtraCharge.first.amount
      end
    end


  	def final_price
      total_price = cart.price + service_charge.price

      if self.check_extra_charge.present?
        total_price = total_price + self.check_extra_charge
      end
      if coupon.present? 
        total_price = total_price - self.check_discount
      end
      self.update(total_price: total_price)
    end    


end
