class CartsController < ApplicationController
before_action :set_cart, only: [:create_transaction]

  def create_transaction
    Transaction.create(status:'active', cart: @cart, postal_fee:PostalFee.first)
    @cart.update(active:false)
    flash[:notice] = 'Berhasil menambahkan product'
      redirect_to root_path
  end

  private
	  def set_cart
	  	@cart = Cart.find(params[:id])
	  end

	  def cart_params
	  	params.require(:cart).permit(:user_id, :price)
	  end
end
