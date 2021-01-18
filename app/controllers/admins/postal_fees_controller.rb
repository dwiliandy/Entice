class Admins::PostalFeesController < AdminsController
	before_action :set_posfee, only: [:show, :edit, :update, :destroy]

  # GET /posfees
  # GET /posfees.json
  def index
    @posfees = PostalFee.all.order(created_at: :desc)
  end

  # GET /posfees/1
  # GET /posfees/1.json
  def show
  end

  # GET /posfees/new
  def new
    @posfee = PostalFee.new
  end

  # GET /posfees/1/edit
  def edit
  end

  # POST /posfees
  # POST /posfees.json
  def create
    @posfee = PostalFee.new(posfee_params)

    respond_to do |format|
      if @posfee.save
      	redirect_to admins_postal_fees_path, notice: 'posfee was successfully created.'
      else
        format.html { render :new }
        format.json { render json: @posfee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posfees/1
  # PATCH/PUT /posfees/1.json
  def update
    respond_to do |format|
      if @posfee.update(posfee_params)
        format.html { redirect_to @posfee, notice: 'posfee was successfully updated.' }
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
    @posfee.destroy
    respond_to do |format|
      format.html { redirect_to postal_fee_url, notice: 'posfee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posfee
      @posfee = PostalFee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def posfee_params
      params.require(:postal_fee).permit(:name, :price)
    end
end
