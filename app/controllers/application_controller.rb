class ApplicationController < ActionController::Base
  before_action :authenticate_user!


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

end
