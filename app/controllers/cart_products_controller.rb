class CartProductsController < ApplicationController
  before_action :set_cart_product

  def index
  end

  def new
    @cart_product = CartProduct.new
  end

  def create
    @cart_product = CartProduct.new(cart_product_params)
    if @cart_product.save
      redirect_to carts_path, notice: "successfully created."
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.

  # Only allow a list of trusted parameters through.
    def cart_product_params
      params.require(:cart_product).permit(:cart_id, :product_id)
    end

    def set_cart_product
      if current_user.carts.where(active:true).last.present?
        @cart_products = current_user.carts.where(active:true).last.cart_products
      else
        @cart_products = []
      end
    end
end
