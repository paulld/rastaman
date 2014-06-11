class ProfileController < ApplicationController

  before_action :is_authenticated?

  def index
  end

  def edit
    @user = current_user
  end

  def update
  end

  protected

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
