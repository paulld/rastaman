class SessionController < ApplicationController

  def new
    @user = User.new
  end

  def create
    case params[:user][:login_form_type]

    when "login"
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
      # send reset password email

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