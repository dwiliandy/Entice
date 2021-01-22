class PagesController < ApplicationController
before_action :authenticate_user!, except: [:index, :about]
  def index
    @q = Product.ransack(params[:q])
		@products = @q.result(distinct: true)
  end
  
  def about
  end

  def profile
  end
  
end
