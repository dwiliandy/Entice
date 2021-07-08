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

	has_many :orders

	validates :name, :presence => true,
    :on => [:update, :create]
    validates :discount, :presence => true,
    :on => [:update, :create]
    validates :qty, :presence => true,
    :on => [:update, :create]
    validates :variety, :presence => true,
    :on => [:update, :create]

	enum variety: {postal: 0, price: 1}

		def status
			if disable == true
				'Not Available'
			else
				'Available'
			end
		end
end
