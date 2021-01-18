class CartsController < ApplicationController
before_action :set_product, only: [:create_cart_product]

  def index
    @carts = current_user.carts.all
  end


  def create_cart_product
  	@cart = Cart.new(cart_params)
  	if @cart.save
  		@cart_product = CartProduct.create(cart_id: @cart.id, product_id: @product.id)
  	end
  end

  private
	  def set_cart
	  	@cart = Cart.find(params[:id])
	  end

	  def set_products
	  	@product = Product.find(params[:id])
	  end

	  def cart_product_params
	    params.require(:cart_product).permit(:cart_id, :product_id)
	  end

	  def cart_params
	  	params.require(:cart).permit(:user_id, :price)
	  end
end
