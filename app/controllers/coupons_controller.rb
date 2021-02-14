class CouponsController < ApplicationController
  def checking
    @coupons = Coupon.find_by("qty > ? and disable = ? and name = ?", 0, false, params[:code])
    if @coupons.present?
      head :ok
    else
      head :not_found
    end
  end

end
