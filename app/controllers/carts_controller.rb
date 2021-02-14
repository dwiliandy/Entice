class CartsController < ApplicationController
before_action :set_cart, only: [:create_transaction]

  def create_transaction
    Transaction.create(status:'active', cart: @cart, postal_fee:PostalFee.first, coupon: Coupon.find_by_id(params["coupon"]) )
    @cart.update(active:false)
    if params[:coupon].present?
      Coupon.find(params[:coupon]).decrement!(:qty)
    end
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
