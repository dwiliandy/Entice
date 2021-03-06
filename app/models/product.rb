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

    validates :name, :presence => true,
    :on => [:update, :create]
    validates :price, :presence => true,
    :on => [:update, :create]
    validates :status, :presence => true,
    :on => [:update, :create]
    validates :description, :presence => true,
    :on => [:update, :create]
    validates :region_id, :presence => true,
    :on => [:update, :create]

    enum status: {ready: 0, not_ready: 1}

    STATUS_OPTIONS=[
    	["Ready", 0],
    	["Not Ready", 1]
    ]
end
