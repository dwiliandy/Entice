class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def profile
  end
  
  def show
  end
  
  def edit
  end


  def update
    if @user.update(user_params)
      sign_in(current_user, :bypass => true)
      redirect_to profile_path, notice: 'Profile has been updated.'
    else
      render 'edit'
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
