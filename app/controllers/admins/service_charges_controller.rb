class Admins::Service_ChargesController < AdminsController
	before_action :set_posfee, only: [:show, :edit, :update, :destroy]

  # GET /posfees
  # GET /posfees.json
  def index
    @q = ServiceCharge.order(created_at: :desc).ransack(params[:q])
		@pagy, @service_charges = pagy(@q.result(distinct: true), items:20)
    
  end

  # GET /posfees/1
  # GET /posfees/1.json
  def show
  end

  # GET /posfees/new
  def new
    @service_charge = ServiceCharge.new
  end

  # GET /posfees/1/edit
  def edit
  end

  # POST /posfees
  # POST /posfees.json
  def create
    @service_charge = ServiceCharge.new(posfee_params)
      if @service_charge.save
      	redirect_to admins_pages_index_path, notice: 'Service Charge was successfully created.'
      else
        render 'new'
      end
  end

  # PATCH/PUT /posfees/1
  # PATCH/PUT /posfees/1.json
  def update
    respond_to do |format|
      if @service_charge.update(posfee_params)
        format.html { redirect_to admins_service_charges_path, notice: 'Service Charge was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_charge }
      else
        format.html { render :edit }
        format.json { render json: @service_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posfees/1
  # DELETE /posfees/1.json
  def destroy
    @service_charge.destroy
    respond_to do |format|
      format.html { redirect_to admins_service_charges_path, notice: 'Postal Fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posfee
      @service_charge = ServiceCharge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def posfee_params
      params.require(:service_charge).permit(:name, :price)
    end
end
