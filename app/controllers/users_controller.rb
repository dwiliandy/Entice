class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.save
        format.html { redirect_to root_path, notice: "Profile was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :address, :password, :password_confirmation)
  end
end
