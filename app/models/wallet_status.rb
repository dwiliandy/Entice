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
  include AASM

  aasm column: :status do
    
    state :pending, initial: true
    state :success, :failed

    event :verified do
      transitions from: :pending, to: :success
    end

    event :fail do
      transitions from: :pending, to: :fail
    end
  end
  belongs_to :wallet
  mount_uploader :proof_of_payment, ProofOfPaymentUploader

  after_create :check_proof

  def check_proof
  	if 1.hour.from_now && self.proof_of_payment.nil?
  		self.fail!
  	else
  		self.verified!
  	end
  end

end
