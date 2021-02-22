# == Schema Information
#
# Table name: wallet_statuses
#
#  id               :bigint           not null, primary key
#  nominal          :float
#  proof_of_payment :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  wallet_id        :bigint           not null
#
# Indexes
#
#  index_wallet_statuses_on_wallet_id  (wallet_id)
#
# Foreign Keys
#
#  fk_rails_...  (wallet_id => wallets.id)
#
class WalletStatus < ApplicationRecord
  belongs_to :wallet
end
