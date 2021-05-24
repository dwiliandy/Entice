class Admins::ExtraChargesController < AdminsController
	before_action :set_extra_charge, only: [:edit, :update]

  
  def edit
  end

  def update
    respond_to do |format|
      if @extra_charge.update(extra_charge_params)
        format.html { redirect_to root_path, notice: 'Extra Charge Succesfully Set.' }
       
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end
  private
   
    def set_extra_charge
      @extra_charge = ExtraCharge.first
    end

   def extra_charge_params
      params.require(:extra_charge).permit(:amount)
    end
end
