class PasswordResetController < ApplicationController

  before_action :is_authenticated?, only: [ :edit_change, :update_change ]

  def edit
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user
    else
      @user = User.new()
      set_login_tab("reset")
      redirect_to login_url, flash: { error: 'Your password reset code has expired!' }
    end
  end

  def update
    if @user = User.find_by_reset_code(params[:password_reset_code])
      if @user.update_password(params[:user][:password], params[:user][:password_confirmation])
        @user.clear_reset_code
        log_user_in(@user)
        redirect_to profile_url, flash: { success: 'Your password has been updated. You are now logged in.' }
      else
        @user = User.find_by_reset_code(params[:password_reset_code])
        flash.now[:error] = 'Please input a valid password.'
        render :edit
      end
    else
      @user = User.new()
      set_login_tab("reset")
      redirect_to "/login", flash: { error: 'Your password reset code has expired!' }
    end
  end


  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
