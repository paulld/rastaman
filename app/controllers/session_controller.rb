class SessionController < ApplicationController

  def new
    @user = User.new
  end

  def create
    case params[:user][:login_form_type]

    when "login"
      @sessionRedMessage = ""
      @sessionGreenMessage = ""
      if @user = User.authenticate(params[:user][:email], params[:user][:password])
        session[:user_id] = @user.id
        redirect_to root_url
      else
        @user = User.new( user_params )
        @sessionRedMessage = "Email and Password don't match"
        render :new
      end

    when "signup"
      @registrant = Registrant.new( user_params )

      if @registrant.save
        EmailValidator.complete_registration(@registrant).deliver

        # render text: "We sent you an email", status: :created
        @sessionGreenMessage = "We sent you an email to confirm your registration"
        @user = User.new( user_params )
        render :new
      else
        @user = User.new( user_params )
        render :new
      end

    else
      if @user = User.find_by( :email => params[:user][:email] )
        @user.generate_password_reset_code

        EmailValidator.password_reset(@user).deliver
        @sessionGreenMessage = "We sent you an email to reset your password"
        @user = User.new( user_params )
        render :new
      else
        @sessionRedMessage = "Email not found, please sign up!"
        @user = User.new( user_params )
        render :new
      end
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