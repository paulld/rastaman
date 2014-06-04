class SessionController < ApplicationController

  def new
    @registrant = Registrant.new
  end

  def create
    registrant = Registrant.new( registrant_params )

    if registrant.save
      EmailValidator.complete_registration(registrant).deliver

      render text: "We sent you an email", status: :created
    else
      render :new
    end
  end

  def destroy
  
  end

  protected

  def registrant_params
    params.require(:registrant).permit( :email )
  end
end