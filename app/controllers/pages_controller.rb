class PagesController < ApplicationController
before_action :authenticate_user!, except: [:index, :about]
  def index
  	@lp = Product.all.order(created_at: :desc)
    @q = @lp.ransack(params[:q])
		@products = @q.result(distinct: true)

    @active_products = Product.ready.order(created_at: :desc)


  end
  
  def about
  end
end
