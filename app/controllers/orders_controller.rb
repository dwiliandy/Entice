class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :cancel]

  # GET /orders
  # GET /orders.json
  def index
    order = current_user.carts.where(active: false).map {|c| c.order.id}
    @q = Order.where(id: order ).ransack(params[:q])
    @orders = @q.result(distinct: true)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Ttransaction was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:total_price, :status, :postal_fee_id, 
        :cart_id, transaction_detail_attributes:[
          :address, :address_detail, :city, :postcode, :phone_number, :recipient_name
        ])
    end

end
