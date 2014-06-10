class ResetController < ApplicationController

  def edit
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user
    else
      @user = User.new()
      redirect_to "/login", flash: { warning: 'Your password reset code has expired!' }
      # TODO: show reset password tab
    end
  end

  def update
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user.update_password(params[:user][:password], params[:user][:password_confirmation])
      if @user.save
        log_user_in(@user)
        redirect_to "/restricted-area", flash: { success: 'You have successfully logged in.' }
      else
        @user = User.find_by_reset_code(params[:password_reset_code])
        flash.now[:warning] = 'Please input a valid password.'
        render :edit
      end
    else
      @user = User.new()
      redirect_to "/login", flash: { warning: 'Your password reset code has expired!' }
      # TODO: show reset password tab
    end
  end

  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
