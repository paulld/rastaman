class SessionController < ApplicationController

  def new
    @registrant = Registrant.new
  end

  def create
    # if this is a sign up
      @registrant = Registrant.new( registrant_params )

      if @registrant.save
        EmailValidator.complete_registration(@registrant).deliver

        render text: "We sent you an email", status: :created
      else
        render :new
      end

    # else if this is a log in attempt
    # find the user with the passed-in email address
    # and authenticate that user with the passed-in password
    # if authentication succeeds, set session user_id
    # and redirect to the root url, otherwise redisplay the form
    
  end

  def destroy
  
  end

  protected

  def registrant_params
    # STRONG PARAMS (SINCE RAILS 4):
    params.require(:registrant).permit( :email )
  end
end