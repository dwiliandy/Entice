class WalletStatusesController < ApplicationController
  # before_action :set_wallet_status, only: [:show, :edit, :update]
  
    def index
      @wallet_statuses = current_user.wallet.wallet_statuses.all.order(created_at: :desc)
      # @pagy, @wallet_statuses = pagy(@q.result(distinct: true), items:20)
    end
  
    def new
      @wallet_status = current_user.wallet.wallet_statuses.new
    end
    def edit
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

    # def update
    #   respond_to do |format|
        
    #     if @wallet_status.update(wallet_status_params)
    #       format.html { redirect_to root_path, notice: 'Wallet Request is being processed' }
    #     else
    #       format.html { render :edit }
    #       format.json { render json: @wallet_status.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end

    private
      def set_wallet_status
        @wallet_status = WalletStatus.find(params[:id])
      end
  
      def wallet_status_params
        params.require(:wallet_status).permit(:nominal, :proof_of_payment, :status)
      end

end
