class Admins::PostalFeesController < AdminsController
	before_action :set_posfee, only: [:show, :edit, :update, :destroy]

  # GET /posfees
  # GET /posfees.json
  def index
    @q = PostalFee.order(created_at: :desc).ransack(params[:q])
		@pagy, @postal_fees = pagy(@q.result(distinct: true), items:20)
    
  end

  # GET /posfees/1
  # GET /posfees/1.json
  def show
  end

  # GET /posfees/new
  def new
    @postal_fee = PostalFee.new
  end

  # GET /posfees/1/edit
  def edit
  end

  # POST /posfees
  # POST /posfees.json
  def create
    @postal_fee = PostalFee.new(posfee_params)
      if @postal_fee.save
      	redirect_to admins_postal_fees_path, notice: 'Postal Fee was successfully created.'
      else
        render 'new'
      end
  end

  # PATCH/PUT /posfees/1
  # PATCH/PUT /posfees/1.json
  def update
    respond_to do |format|
      if @postal_fee.update(posfee_params)
        format.html { redirect_to admins_postal_fees_path, notice: 'Postal Fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @posfee }
      else
        format.html { render :edit }
        format.json { render json: @posfee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posfees/1
  # DELETE /posfees/1.json
  def destroy
    @postal_fee.destroy
    respond_to do |format|
      format.html { redirect_to admins_postal_fees_path, notice: 'Postal Fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posfee
      @postal_fee = PostalFee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def posfee_params
      params.require(:postal_fee).permit(:name, :price)
    end
end
