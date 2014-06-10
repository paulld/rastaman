class SessionController < ApplicationController

  def new
    @user = User.new
  end

  def create
    case params[:user][:login_form_type]

    when "login"
      if @user = User.authenticate(params[:user][:email], params[:user][:password])
        log_user_in(@user)
        redirect_to "/restricted-area", flash: { success: 'You have successfully logged in.' }
      else
        @user = User.new( user_params )
        flash.now[:warning] = 'Email and Password don\'t match. Please try again or try to reset your password.'
        render :new
      end

    when "signup"
      @registrant = Registrant.new( user_params )

      if @registrant.save
        EmailValidator.complete_registration(@registrant).deliver
        # render text: "We sent you an email", status: :created                 # TODO: what does status: :created do ??
        @user = User.new( user_params )
        flash.now[:alert] = 'We sent you an email to confirm your registration. Please check your emails.'
        render :new
      else
        @user = User.new( user_params )
        flash.now[:warning] = 'Unvalid email address. Please try again.'
        @showTab = "signup"
        render :new
      end

    else
      if @user = User.find_by( :email => params[:user][:email] )        # TODO: diff params[:user][:email] and user_params[:email] ??
        @user.generate_password_reset_code
        EmailValidator.password_reset(@user).deliver
        @user = User.new( user_params )
        flash.now[:alert] = 'We sent you an email to reset your password.'
        render :new
      else
        flash[:warning] = "Email not found, please sign up!"
        @user = User.new( user_params )
        @showTab = "signup"
        render :new
      end
    end

  end

  def destroy
    log_user_out
    redirect_to login_url, flash: { alert: 'You have successfully logged out.' }
  end

  protected

  def user_params
    params.require(:user).permit( :email )
  end
end