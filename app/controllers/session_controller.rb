class SessionController < ApplicationController

  def new
    @user = User.new
  end

  def create
    case params[:user][:login_form_type]

    when "login"
      if @user = User.authenticate(params[:user][:email], params[:user][:password])
        session[:user_id] = @user.id
        redirect_to root_url
      else
        @user = User.new( user_params )
        render :new
      end

    when "signup"
      @registrant = Registrant.new( user_params )

      if @registrant.save
        EmailValidator.complete_registration(@registrant).deliver

        render text: "We sent you an email", status: :created
      else
        @user = User.new( user_params )
        render :new
      end

    else
      render text: "Resetting the password!"
      # Find user with params[:user][:email] email address
      # if not found, send "not found!" message
      # if found, send password reset email
      # if @user = User.find
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end

  protected

  def user_params
    # STRONG PARAMS (SINCE RAILS 4):
    params.require(:user).permit( :email )
  end
end