class CartsController < ApplicationController
before_action :set_cart, only: [:create_transaction]

  def create_transaction
    if @cart.order.present?
      @trans = @cart.order
    else
      @trans = Order.create(status:'pending', cart: @cart, postal_fee:PostalFee.first, coupon: Coupon.find_by_id(params["coupon"]))
      TransactionDetail.create(order:@trans)
      if params[:coupon].present?
        Coupon.find(params[:coupon]).decrement!(:qty)
      end
    end
    @cart.update(active:false)
    flash[:notice] = 'Berhasil menambahkan product'
    redirect_to edit_order_path(@trans)
  end


  private
    def set_cart
	  	@cart = Cart.find(params[:id])
	  end

	  def cart_params
	  	params.require(:cart).permit(:user_id, :price)
	  end
end
