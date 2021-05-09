ActionView::Helpers::DateHelper

class ProductsController < ApplicationController
  before_action :set_product
  before_action :set_cart, only: [:add_cart_product]

  def show
    @comments = Comment.where(product: @product).order(created_at: :desc)
  end

  def add_cart_product
    if @cart.products.ids.include? params[:id].to_i
      if params[:product].present?
        @cart.cart_products.find_by(product_id: params[:id]).update(product:@product, quantity:params[:product][:qty])
      else
        @cart.cart_products.find_by(product_id: params[:id]).update(product:@product, quantity:1)
      end
    else
      if params[:product].present?
        @cart.cart_products.create(product:@product, quantity:params[:product][:qty])
      else
        @cart.cart_products.create(product:@product, quantity:1)
      end
    end
      flash[:notice] = 'Successfully put in to Cart'
      redirect_to cart_products_path
  end

  def create_comment
    
    if params[:content][:message].present?
      Comment.create(content: params[:content][:message], user: current_user, product: @product)
      redirect_to product_path(@product), notice: "Comment has been posted"
    else
      redirect_to product_path(@product)
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_cart
      if current_user.present?
        if current_user.carts.where(active:true).last.present?
          @cart = current_user.carts.where(active:true).last
        else
          @cart = current_user.carts.create(active:true, user:current_user)
        end
      else
        redirect_to  new_user_session_path 
      end
    end

    def product_params
      params.require(:product).permit(:price, :description, :name, :image, :status, :region_id)
    end
end
