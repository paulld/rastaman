class RegistrationController < ApplicationController

  def new
    if @registrant = Registrant.find_by_code(params[:sign_up_code])
      @user = User.new(email: @registrant.email)
    else
      redirect_to "/login", flash: { warning: 'Your registration is expired. Please sign up.' }
      # TODO: show sign up tab
    end
  end

  def create
    if @registrant = Registrant.find_by_code(params[:sign_up_code])
      @user = User.new( user_params.merge(email: @registrant.email) )

      if @user.save
        @registrant.destroy
        log_user_in(@user)
        redirect_to "/restricted-area", flash: { success: 'You have successfully logged in.' }
      else
        flash.now[:warning] = 'Please input a valid password.'
        render :new
      end
    else
      redirect_to "/login", flash: { warning: 'Your registration is expired. Please sign up.' }
      # TODO: show sign up tab
    end
  end

  protected

  def user_params
    # Strong params = white list = only fields that are allowed to be passed in the form
    params.require(:user).permit( :password, :password_confirmation )
  end
end
