class SiteController < ApplicationController
  
  def index
    @registrants = Registrant.all.entries
    @users = User.all.entries
    if session[:user_id]
      @message = "You are logged in with the user_id: #{session[:user_id]}"
    else
      @message = "You are not logged in"
    end
  end
end
