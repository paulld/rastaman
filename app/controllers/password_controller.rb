class PasswordController < ApplicationController

  before_action :is_authenticated?, only: [ :edit_change, :update_change ]

  def edit_reset
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user
    else
      @user = User.new()
      set_login_tab("reset")
      redirect_to login_url, flash: { error: 'Your password reset code has expired!' }
    end
  end

  def update_reset
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user.update_password(params[:user][:password], params[:user][:password_confirmation])
      if @user.save
        log_user_in(@user)
        redirect_to profile_url, flash: { success: 'Your password has been updated. You are now logged in.' }
      else
        @user = User.find_by_reset_code(params[:password_reset_code])
        flash.now[:error] = 'Please input a valid password.'
        render :edit_reset
      end
    else
      @user = User.new()
      set_login_tab("reset")
      redirect_to "/login", flash: { error: 'Your password reset code has expired!' }
    end
  end

  def edit_change
    @user = current_user
  end

  def update_change
    @user = current_user
    @user.update_password(params[:user][:password], params[:user][:password_confirmation])
    if @user.save
        redirect_to profile_url, flash: { success: 'Your password has been updated' }
      else
        @user = current_user
        flash.now[:error] = 'Please input a valid password.'
        render :edit_change
      end
  end


  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
