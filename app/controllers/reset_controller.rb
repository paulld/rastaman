class ResetController < ApplicationController

  def edit
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user
    else
      render text: "Your reset code is expired!"
    end
  end

  def update
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user.update_password(params[:user][:password], params[:user][:password_confirmation])
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_url
      else
        render :edit
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
