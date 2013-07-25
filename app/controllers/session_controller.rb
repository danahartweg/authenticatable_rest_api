class SessionController < ApplicationController

	# Clearing a session requires you to be authenticated
  before_filter :ensure_authenticated_user, only: [:destroy]

  # Logging the user in
  def create
    user = User.where("username = ? OR email = ?", params[:username_or_email], params[:username_or_email]).first

    if user && user.authenticate(params[:password])
      render json: user.session_api_key, status: 201
    else
      render json: {}, status: 401
    end
  end

  # Clearing user key when they log out
  def destroy
  	if ApiKey.where(access_token: '#{token}').destroy_all
  		render json: {}, status: 200
  	else
  		render json: {}, status: 422
  	end
  end

end
