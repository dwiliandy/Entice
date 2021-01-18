# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  active     :boolean
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
	accepts_nested_attributes_for :cart_products

	has_many :products, :through => :cart_products

	has_one :trans, class_name: "Transaction"
	accepts_nested_attributes_for :trans
	
  	belongs_to :user

  
  def sum
    cart_products.map {|p| p.product.price * p.quantity}.sum
  end
end
