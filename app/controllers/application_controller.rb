class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # def application
  #   # @users = User.all.entries
  # if @session[:user_id]
  #   @messageLoginApp = "logged in"
    
  # else
  #   @messageLoginApp = "not logged in"
  #   # @messageLogout = "You are not logged in"
  # end
  # end
end
