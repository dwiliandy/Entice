class CartProductsController < ApplicationController

  def new
    byebug
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


end
