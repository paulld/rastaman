class SessionController < ApplicationController

  def new
  end

  def create
    registrant = Registrant.new( registrant_params )

    if registrant.save
      render json: registrant, status: :created
    else
      render :new
    end
  end

  protected

  def registrant_params
    params.require(:registrant).permit( :email )
  end
end