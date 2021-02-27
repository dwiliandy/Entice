class Admins::WalletStatusesController < AdminsController
	before_action :set_wallet_statuses, only: [:edit, :update]

  def index
    @a = WalletStatus.all.order(created_at: :desc)
    @q = @a.ransack(params[:q])
    @pagy, @wallet_statuses = pagy(@q.result(distinct: true), items:20)
    
  end

  def edit
  end

    def update
	  if @wallet.update(wallet_params)
	    redirect_to admins_wallet_status_path, notice: "#{@wallet.user.name.titleize} wallet was successfully updated."
	  else
	    render 'edit'
	  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet_status = WalletStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:nominal)
    end
end
