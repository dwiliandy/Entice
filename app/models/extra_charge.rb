# == Schema Information
#
# Table name: extra_charges
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ExtraCharge < ApplicationRecord
  has_many :orders

  validates :amount, :presence => true,
    :on => [:update, :create]

end
