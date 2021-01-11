class CartsController < ApplicationController

  def index
    @carts = current_user.carts.all
  end

end
