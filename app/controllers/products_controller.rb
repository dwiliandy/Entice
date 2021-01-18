class ProductsController < ApplicationController
  before_action :set_product
  before_action :set_cart, only: [:add_cart_product]

  def show
  end

  def add_cart_product
      @cart.cart_products.create(product:@product, quantity:params[:product][:qty])
      flash[:notice] = 'Berhasil dimasukkan dalam cart'
      redirect_to cart_products_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_cart
      if current_user.carts.where(active:true).last.present?
        @cart = current_user.carts.where(active:true).last
      else
        @cart = current_user.carts.create(active:true, user:current_user)
      end
    end

    def product_params
      params.require(:product).permit(:price, :description, :name, :image, :status, :stock, :region_id)
    end
end
