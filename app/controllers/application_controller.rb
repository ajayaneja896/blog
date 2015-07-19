class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_initials

  def set_initials
    @instagram = Instagram.user_recent_media(1412623027, {:count => 1})
  end
  helper_method :admin?
   protected
    def  admin?
     session[:parameter]
   end
    def authenticate
      unless admin?
        flash[:error]="unauthorized access!"

        redirect_to posts_url
      end

    end

end
