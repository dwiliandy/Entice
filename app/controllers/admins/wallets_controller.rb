class Admins::WalletsController < AdminsController
	before_action :set_wallet, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    @wallets = Wallet.where(user: User.where(role: 0)).order(created_at: :desc)
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @wallet = Wallet.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @wallet = Wallet.new(wallet_params)

      if @wallet.save
      	redirect_to admins_wallets_path, notice: "#{@wallet.user.name.titleize} wallet was successfully created."
      else
        render 'new'
      end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
	  if @wallet.update(wallet_params)
	    redirect_to admins_wallets_path, notice: "#{@wallet.user.name.titleize} wallet was successfully updated."
	  else
	    render 'edit'
	  end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @wallet.destroy
    respond_to do |format|
      format.html { redirect_to admins_wallets_path, notice: 'Wallet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:nominal)
    end
end
