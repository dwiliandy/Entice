class CartsController < ApplicationController
before_action :set_cart, only: [:create_transaction]

  def create_transaction
    if @cart.order.present?
      @trans = @cart.order
      @trans.final_price
      if params[:coupon].present?
        @trans.update(coupon_id: params[:coupon].to_i)
      else params[:coupon].blank?
        @trans.update(coupon_id: nil)
      end
    else
      @status = 'pending'
      @service_charge_id = ServiceCharge.first.id
      @coupon_id = Coupon.find(params[:coupon]).id
      @trans = Order.create(status:@status, cart: @cart, service_charge_id:@service_charge_id, coupon_id: @coupon_id)
      TransactionDetail.create(order:@trans)
    end   
    flash[:notice] = 'Berhasil menambahkan product'
    if @trans.coupon.present?
      Coupon.find(@trans.coupon.id).decrement!(:qty)
    end
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
