class Admins::TransactionsController < AdminsController
	before_action :set_transaction, only: [:show, :edit, :update, :destroy, :transition, :input_receiver, :input_receipt]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all.order(created_at: :desc)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to admins_transactions_path, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to admins_transactions_path, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to admins_transactions_path, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def input_receiver
    respond_to do |format|
      # if @transaction.update(transaction_params)
        format.html 
        format.js
      # else
      #   format.html { render :edit }
      #   format.js
      # end
    end
  end

  def input_receipt
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html {redirect_to admins_transactions_path, notice: "Receipt Number has been inputted"}
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def transition
    if @transaction.pending?
      @transaction.verified!
    elsif @transaction.active?
      @transaction.processing!
    elsif @transaction.processed?
      @transaction.deliver!
    elsif @transaction.delivery?
      @transaction.arrived!
    elsif @transaction.delivered?
      @transaction.completion!
    elsif @transaction.finished?
      @transaction.review!
    end
    redirect_to admins_transactions_path, notice: 'Transaction Has Been Updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
        @transaction = Transaction.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:receiver, :receipt_number)
    end
end
