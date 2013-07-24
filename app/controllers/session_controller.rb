class SessionController < ApplicationController

  # Legacy code for UI logins
  # def create
  #   user = User.from_omniauth(env["omniauth.auth"])
  #   session[:user_id] = user.id
  #   redirect_to root_url, notice: "Signed in!"
  # end

  # def destroy
  #   session[:user_id] = nil
  #   redirect_to root_url, notice: "Signed out!"
  # end

  # def failure
  #   redirect_to root_url, alert: "Authentication failed, please try again."
  # end

  def create
    user = User.where("username = ? OR email = ?", params[:username_or_email], params[:username_or_email]).first

    if user && user.authenticate(params[:password])
      render json: user.session_api_key, status: 201
    else
      render json: {}, status: 401
    end
  end

  # def destroy
  #   # expire the existing auth token
  #   @user = User.where(:authentication_token => params[:api_key]).first
  #   @user.reset_authentication_token!
  #   render :json => { :message => ["Session deleted."] }, :success => true, :status => :ok
  # end

  # def invalid_login_attempt
  #   puts "warden failure"
  #   warden.custom_failure!
  #   render :json => { :errors => ["Invalid email or password."] }, :success => false, status: 401
  # end

end
