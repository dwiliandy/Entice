class Admins::CouponsController < AdminsController
	before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  def index
    @q = Coupon.order(created_at: :desc).ransack(params[:q])
    @pagy, @coupons = pagy(@q.result(distinct: true), items:20)
  end

  def show
  end

  def new
    @coupon = Coupon.new
  end

  def edit
  end

  def create
    @coupon = Coupon.new(coupon_params)

      if @coupon.save
      	redirect_to admins_coupons_path, notice: 'Coupon was successfully created.'
      else
        render 'new'
      end
  end

  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to admins_coupons_path, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to admins_coupons_path, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

   def coupon_params
      params.require(:coupon).permit(:name, :disable, :discount, :qty, :variety)
    end
end
