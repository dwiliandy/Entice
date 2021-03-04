class WalletStatusesController < ApplicationController
  
    def index
      @wallet_statuses = current_user.wallet.wallet_statuses.all.order(created_at: :desc)
    end
  
    def new
      @wallet_status = current_user.wallet.wallet_statuses.new
    end
    
    def create
      @wallet_status = current_user.wallet.wallet_statuses.new(wallet_status_params)
      respond_to do |format|
        if @wallet_status.save
          format.html { redirect_to root_path, notice: 'Wallet Request is being processed' }
        else
          format.html { render :new }
          format.json { render json: @wallet_status.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      def set_wallet_status
        @wallet_status = WalletStatus.find(params[:id])
      end
  
      def wallet_status_params
        params.require(:wallet_status).permit(:nominal, :proof_of_payment, :status)
      end

end
