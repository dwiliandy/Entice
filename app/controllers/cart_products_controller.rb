class CartProductsController < ApplicationController
  before_action :set_cart_products
  before_action :set_coupon, only: [:index]
  before_action :set_cart_product, only: [:destroy, :edit, :update, :change_quantity]
  def index
  
  end

  def new
    @cart_product = CartProduct.new
  end

  def check
    	@code = Coupon.find_by("qty > ? and disable = ? and name = ?", 0, false, params[:code])
    	if @code.present?
    		flash[:notice] = "Code Has Been Submitted"
    	else
    		flash[:notice] = "Code not Valid"
    	end
      redirect_to cart_products_path(coupon: @code.id)
    end
  # def create
  #   @cart_product = CartProduct.new(cart_product_params)
  #   if @cart_product.save
  #     redirect_to carts_path, notice: "successfully created."
  #   end
  # end

  def destroy
    @cart_product.destroy
    respond_to do |format|
      format.html { redirect_to cart_products_path, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def change_quantity
    qty = params[:qty]
    @cart_product.update(quantity: qty)
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Only allow a list of trusted parameters through.
   
    def set_coupon
      if params["coupon"].present?
        @coupon = params["coupon"]
      end
    end
  
    def set_cart_product
      @cart_product = CartProduct.find(params[:id])
    end

    def cart_product_params
      params.require(:cart_product).permit(:cart_id, :product_id, :quantity)
    end

    def set_cart_products
      if current_user.carts.where(active:true).last.present?
        @cart_products = current_user.carts.where(active:true).last.cart_products
      else
        @cart_products = []
      end
    end
end
