# == Schema Information
#
# Table name: carts
#
#  id             :bigint           not null, primary key
#  price          :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  transaction_id :bigint           not null
#
# Indexes
#
#  index_carts_on_transaction_id  (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (transaction_id => transactions.id)
#
class Cart < ApplicationRecord
	belongs_to :transaction, dependent: :destroy
	has_many :cart_products
	has_many :products, through: :cart_products


	class << self
		def total_price
			price = products.each {|p| p.price}.sum
		end
	end
end
