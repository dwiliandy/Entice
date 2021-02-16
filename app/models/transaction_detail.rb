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
#  transaction_id :bigint           not null
#
# Indexes
#
#  index_transaction_details_on_transaction_id  (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (transaction_id => transactions.id)
#
class TransactionDetail < ApplicationRecord
  belongs_to :transaction
end
