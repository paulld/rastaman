class SiteController < ApplicationController
  
  def index
    @registrants = Registrant.all.entries
    @users = User.all.entries
  end
end
