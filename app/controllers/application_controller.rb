class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # def application
  #   # @users = User.all.entries
  #   if session[:user_id]
  #     @messageLogin = "You are logged in with the user_id: #{session[:user_id]}"
  #     @messageLogout = ""
  #   else
  #     @messageLogin = ""
  #     @messageLogout = "You are not logged in"
  #   end
  # end
end
