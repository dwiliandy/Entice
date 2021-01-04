class ProductsController < ApplicationController
  before_action :set_product
  def show
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:price, :description, :name, :image, :status, :stock, :region_id)
    end
end
