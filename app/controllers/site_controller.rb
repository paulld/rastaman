class SiteController < ApplicationController
  
  before_action :is_authenticated?, only: [ :restricted ]

  def index
    @registrants = Registrant.all.entries
    @users = User.all.entries
  end

  def about
  end

  def restricted
  end

end
