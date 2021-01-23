class CouponsController < ApplicationController
  def checking
    @coupons = Coupon.find_by(name: params[:code], disable: false)
    if @coupons.present?
      head :ok
    else
      head :not_found
    end
  end

end
