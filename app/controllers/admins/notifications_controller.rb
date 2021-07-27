class Admins::NotificationsController < AdminsController
	before_action :set_notification, only: [:show]

  def index
    @notifications = current_user.notifications.all
  end


  private
   
    def set_notification
      @notification = Notification.find(params[:id])
    end

end
