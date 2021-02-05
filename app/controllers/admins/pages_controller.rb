class Admins::PagesController < AdminsController
  def index
   @mounthly_earings = Transaction.where(created_at: 1.month.ago.beginning_of_month..1.month.ago.end_of_month, status: ['finished', 'reviewed']).sum(:total_price)
   @this_month_earings = Transaction.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month, status: ['finished', 'reviewed']).sum(:total_price)
   @transactions_count = Transaction.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month, status: ['finished', 'reviewed']).count
   @transactions_active = Transaction.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month).where.not(status:['reviewed','finished','canceled']).count
	end

end
