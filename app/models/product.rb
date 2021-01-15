# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  name        :string
#  price       :float
#  status      :integer
#  stock       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_id   :bigint
#
# Indexes
#
#  index_products_on_region_id  (region_id)
#
class Product < ApplicationRecord
    belongs_to :region, dependent: :destroy

    has_many :cart_products, dependent: :nullify
    has_many :carts, :through => :cart_products

    has_many :comments
    mount_uploader :image, ImageUploader

    enum status: {available: 0, out_of_stock: 1}

    STATUS_OPTIONS=[
    	["Available", 0],
    	["Out of Stock", 1]
    ]
end
