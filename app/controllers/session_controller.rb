class SessionController < ApplicationController

  def login

    authenticate_or_request_with_http_basic do |user_name,password|
       user_name=='admin'
       password=='secret'
       session[:parameter] = true
       user_name=='buffalo'
       password='uhell'
     end

  end


  def logout
    reset_session
  end
end
