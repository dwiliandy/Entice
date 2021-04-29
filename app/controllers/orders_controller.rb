class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :cancel]

  def index
    order = current_user.carts.where(active: false).map {|c| c.order.id}
    @q = Order.where(id: order).order(created_at: :desc).ransack(params[:q])
    @orders = @q.result(distinct: true)
  end


  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end
  
  def create
    @order = Order.new
    respond_to do |format|
        if current_user.wallet.nominal - @order.total_price < 0
          flash[:alert] = "Wallet is not enough"
          redirect_to root_path
        else
          if @order.save
          wallet = @order.user.wallet.nominal - @order.total_price
          @order.user.wallet.update(nominal: wallet)       
          format.html { redirect_to @order, notice: 'Ttransaction was successfully created.' }
        else
          format.html { render :new }
        end
      end

      
    end
  end

  def update
    respond_to do |format|
      
      if @order.status.eql?"pending" and (current_user.wallet.nominal - @order.total_price < 0)
        flash[:alert] = "Wallet is not enough"
        format.html { render :edit }
        @order.cart.update(active:true)
      else
        if @order.update(order_params)
          @order.cart.update(active:false)
          wallet = current_user.wallet.nominal - @order.total_price
          current_user.wallet.update(nominal: wallet)
          @order.cart.cart_products.each do |product|
            decrement_prod_qty = product.product.stock - product.quantity 
              product.product.update(stock: decrement_prod_qty)
          end
          format.html { redirect_to root_path, notice: 'Transaction was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cancel
    if @order.pending? || @order.active?
      @order.canceling!
    end
    redirect_to orders_path, notice: 'Your transaction has been canceled'
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:total_price, :status, :postal_fee_id,:note, 
        :cart_id, transaction_detail_attributes:[:id,
          :address, :address_detail, :city, :postcode, 
          :phone_number, :recipient_name, :order_id
        ])
    end

end
