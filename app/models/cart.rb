# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cart < ApplicationRecord
	has_many :cart_products
	has_many :products, :through => :cart_products
	has_one :trans, foreign_key: "transaction_id", class_name: "Transaction"
  	belongs_to :user

	class << self
		def sum_price
			price = products.map {|p| p.price}.sum
		end
	end
end
