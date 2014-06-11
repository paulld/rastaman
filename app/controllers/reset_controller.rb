class ResetController < ApplicationController

  def edit
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user
    else
      @user = User.new()
      # TODO: show reset password tab
      # @show_login_tab = "reset"
      set_login_tab("reset")
      # render "session/new"
      redirect_to "/login", flash: { error: 'Your password reset code has expired!' }
      # redirect_to "/login"(:showTab => @showTab), flash: { error: 'Your password reset code has expired!' }
      # logger.info @showTab
    end
  end

  def update
    if @user = User.find_by_reset_code(params[:password_reset_code])
      @user.update_password(params[:user][:password], params[:user][:password_confirmation])
      if @user.save
        log_user_in(@user)
        redirect_to "/restricted-area", flash: { success: 'Your password has been updated. You are now logged in.' }
      else
        @user = User.find_by_reset_code(params[:password_reset_code])
        flash.now[:error] = 'Please input a valid password.'
        render :edit
      end
    else
      @user = User.new()
      # TODO: show reset password tab
      # @show_login_tab = "reset"
      set_login_tab("reset")
      redirect_to "/login", flash: { error: 'Your password reset code has expired!' }
    end
  end

  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
