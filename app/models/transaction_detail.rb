# == Schema Information
#
# Table name: transaction_details
#
#  id             :bigint           not null, primary key
#  address        :string
#  address_detail :text
#  city           :string
#  phone_number   :string
#  postcode       :string
#  recipient_name :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  order_id       :bigint
#
# Indexes
#
#  index_transaction_details_on_order_id  (order_id)
#
class TransactionDetail < ApplicationRecord
  belongs_to :order


  #validate
  validates :recipient_name, :presence => true,
   :on => :update
  validates :address, :presence => true,
   :on => :update
  validates :city, :presence => true,
   :on => :update
  validates :postcode, :presence => true,
   :on => :update
  validates :phone_number, :presence => true,
   :on => :update
end
