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
    belongs_to :region
    mount_uploader :image, ImageUploader
end
