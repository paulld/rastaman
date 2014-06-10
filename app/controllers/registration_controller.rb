class RegistrationController < ApplicationController

  def new
    @registerRedMessage = ""
    if @registrant = Registrant.find_by_code(params[:sign_up_code])
      @user = User.new(email: @registrant.email)
    else
      render text: "Your registration is expired!"
      # @user = User.new()
      # @registerRedMessage = "Your registration is expired!"
      # redirect_to login_url
    end
  end

  def create
    if @registrant = Registrant.find_by_code(params[:sign_up_code])
      @user = User.new( user_params.merge(email: @registrant.email) )

      if @user.save
        @registrant.destroy
        log_user_in(@user)
        # TODO: ADD FLASH
        redirect_to root_url
      else
        @registerRedMessage = "please input valid passord"
        render :new
      end
    else
      render "Your registration is expired!"
    end
  end

  protected

  def user_params
    # Strong params = white list = only fields that are allowed to be passed in the form
    params.require(:user).permit( :password, :password_confirmation )
  end
end
