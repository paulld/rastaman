class ResetController < ApplicationController

  def new
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user
    else
      render text: "Your reset code is expired!"
    end
  end

  def update
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user
      if @user.save
        @user[:password_reset_code] = ""
        @user.save
        session[:user_id] = @user.id
        redirect_to root_url
      else
        render :new
      end
    else
      render "Your reset code is expired!"
    end
  end

  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
