class SiteController < ApplicationController
  
  def index
    @registrants = Registrant.all.entries
  end
end
