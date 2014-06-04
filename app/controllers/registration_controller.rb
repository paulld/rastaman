class RegistrationController < ApplicationController

  def new
    @registrant = Registrant.find_by(sign_up_code: params[:sign_up_code])
    @user = User.new(email: @registrant.email)
  end

  def create
    @registrant = Registrant.find_by(sign_up_code: params[:sign_up_code])
    @user = User.new( user_params.merge(email: @registrant.email) )

    if @user.save
      # redirect_to root_url
      render json: @user
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end