# == Schema Information
#
# Table name: transaction_details
#
#  id             :bigint           not null, primary key
#  address        :text             not null
#  address_detail :text
#  city           :string           not null
#  phone_number   :string           not null
#  postcode       :string           not null
#  recipient_name :string           not null
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
end
