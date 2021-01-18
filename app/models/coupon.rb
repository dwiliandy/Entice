# == Schema Information
#
# Table name: coupons
#
#  id         :bigint           not null, primary key
#  disable    :boolean          default(FALSE)
#  discount   :integer
#  name       :string
#  qty        :integer
#  variety    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Coupon < ApplicationRecord

	has_many :transactions

	enum variety: {postal: 0, price: 1}

		def status
			if disable == true
				'Not Available'
			else
				'Available'
			end
		end
end
