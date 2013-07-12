class SessionsController < ApplicationController

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
    user = User.find_for_database_authentication(:email => params[:email])
    return invalid_login_attempt unless user

    if user.valid_password?(params[:password])
      user.ensure_authentication_token!
      render :json => { :authentication_token => user.authentication_token, :user_id => user.id }, status: 201
    end
  end

  def destroy
    # expire the existing auth token
    @user = User.where(:authentication_token => params[:api_key]).first
    @user.reset_authentication_token!
    render :json => { :message => ["Session deleted."] }, :success => true, :status => :ok
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json => { :errors => ["Invalid email or password."] }, :success => false, status: 401
  end

end
