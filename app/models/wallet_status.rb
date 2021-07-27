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
  validates :nominal, numericality: { greater_than: 10000 }
  validates :proof_of_payment, presence: true
  aasm column: :status do
    
    state :pending, initial: true
    state :success, :failed

    event :verified do
      transitions from: :pending, to: :success
    end

    event :expire do
      transitions from: :pending, to: :failed
    end
  end
  belongs_to :wallet
  mount_uploader :proof_of_payment, ProofOfPaymentUploader

  after_update :update_wallet

  def update_wallet
    if self.status == 'success'
      wallet_nominal = self.wallet.nominal + nominal
      self.wallet.update(nominal: wallet_nominal)
    end
  end

end
