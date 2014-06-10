class SiteController < ApplicationController
  
  before_action :is_authenticated?, only: [ :restricted ]

  def index
    @registrants = Registrant.all.entries
    @users = User.all.entries

    if session[:user_id]
      @messageLogin = "You are logged in with the user_id: #{session[:user_id]}"
      @messageLogout = ""
    else
      @messageLogin = ""
      @messageLogout = "You are not logged in"
    end
  end

  def about
  end

  def restricted
  end

end
