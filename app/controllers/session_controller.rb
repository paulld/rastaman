class SessionController < ApplicationController

  def new
    @registrant = Registrant.new
    @user = User.new
  end

  def create
    # if this is a sign up
    if params[:commit] == "Sign up"
      @registrant = Registrant.new( registrant_params )

        if @registrant.save
          EmailValidator.complete_registration(@registrant).deliver
          render text: "We sent you an email", status: :created
        else
          render :new
        end

    else
    # else if this is a log in attempt
    # if params[:user][:password_confirmation] = 'login'
    # First check if user email can be found in the database
      if @user = User.find_by(email: params[:user][:email])
        # user email has been found, now check his password
        
        if @user.authenticate( params[:user][:password] )
          # user email and password match, open session
          session[:user_id] = @user.id
          redirect_to root_url
        
        else
          # user email and password don't match, message + redisplay the form
          render text: "Wrong password"  #, status: :created
        end
      
      else
        # user email not found, ask him to sign up
        render text: "Email not found, please sign up"  #, status: :created
      
      end
    end

    # find the user with the passed-in email address
    # and authenticate that user with the passed-in password
    # if authentication succeeds, set session user_id
    # and redirect to the root url, otherwise redisplay the form
    
  end

  def destroy
  
  end

  protected

  def user_params
    params.require(:user).permit( :email, :password, :process )
  end

  def registrant_params
    # STRONG PARAMS (SINCE RAILS 4):
    params.require(:registrant).permit( :email )
  end
end