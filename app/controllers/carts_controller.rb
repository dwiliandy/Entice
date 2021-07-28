class CartsController < ApplicationController
before_action :set_cart, only: [:create_transaction]

  def create_transaction
    if @cart.order.present?
      @trans = @cart.order
      @region = @cart.products.pluck(:region_id).max
      if (1..282).include? (@region)
        @service_charge_id = ServiceCharge.first.id
      elsif (283..451).include? (@region)
        @service_charge_id = ServiceCharge.second.id
      else
        @service_charge_id = ServiceCharge.last.id
      end
      @trans.update(service_charge_id: @service_charge_id)
      if params[:coupon].present?
        @trans.update(coupon_id: params[:coupon].to_i)
      else params[:coupon].blank?
        @trans.update(coupon_id: nil)
      end
    else
      @status = 'pending'
      @region = @cart.products.pluck(:region_id).max
      if (1..282).include? (@region)
        @service_charge_id = ServiceCharge.first.id
      elsif (452..514).include? (@region)
        @service_charge_id = ServiceCharge.last.id
      else
        @service_charge_id = ServiceCharge.second.id
      end
      @coupon_id = @coupon_id = Coupon.find(params[:coupon]).id if params[:coupon].present?
      @trans = Order.create(status:@status, cart: @cart, service_charge_id:@service_charge_id, coupon_id: @coupon_id)
      TransactionDetail.create(order:@trans)
    end   
    flash[:notice] = 'Berhasil menambahkan product'
     @trans.final_price
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
