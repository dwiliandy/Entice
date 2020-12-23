class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    # check for the class of the object to determine what type it is
    case resource.role
    when "admin"
      admins_pages_index_path
    when "customer"
      root_path
    else
      root_path
    end
  end


  protected

       def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) {
               |u| u.permit(:name, :email, :password, :address, :phone_number, :role)}

            devise_parameter_sanitizer.permit(:account_update) {
               |u| u.permit(:name, :email, :password, :current_password, :address, :phone_number, :role )}
       end

end
