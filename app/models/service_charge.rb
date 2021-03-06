# == Schema Information
#
# Table name: service_charges
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ServiceCharge < ApplicationRecord
	has_many :orders
	validates :name, :presence => true,
    :on => [:update, :create]
    validates :price, :presence => true,
    :on => [:update, :create]
end
