class SessionController < ApplicationController

  def new
    @registrant = Registrant.new
    @user = User.new
  end

  def create

    if params[:commit] == "Sign up"
      @registrant = Registrant.new( registrant_params )
        if @registrant.save
          EmailValidator.complete_registration(@registrant).deliver
          render text: "We sent you an email", status: :created
        else
          render :new
        end

    else
      if @user = User.find_by(email: user_params[:email])
        if @user.authenticate( user_params[:password] )
          session[:user_id] = @user.id
          render text: "Well done!"
        else
          render text: "Wrong password"  #, status: :created
        end
      else
        render text: "Email not found, please sign up"  #, status: :created
      end

    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end

  protected

  def user_params
    params.require(:user).permit( :email, :password )
  end

  def registrant_params
    # STRONG PARAMS (SINCE RAILS 4):
    params.require(:registrant).permit( :email )
  end
end