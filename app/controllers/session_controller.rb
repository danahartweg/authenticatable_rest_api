class SessionController < ApplicationController

	# Clearing a session requires you to be authenticated
  before_filter :ensure_authenticated_user, :only => [:destroy]

  # Logging the user in
  def create
    user = User.where("username = ? OR email = ?", params[:username_or_email], params[:username_or_email]).first

    if user && user.authenticate(params[:password])
    	api_key = user.find_api_key

      if !api_key.is_locked
        api_key.last_access = Time.now

        if !api_key.access_token || api_key.is_expired
          puts "non existant or expired key, generating"
          api_key.set_expiry_date
          api_key.generate_access_token
        end

        api_key.save

        render json: api_key, status: 201
      else
        render json: { errors: 'Your account has been locked.' }, status: 401
      end

    else
      render json: { errors: user.errors.messages }, status: 401
    end
  end

  # Clearing user key when they log out
  def destroy

  	api_key = ApiKey.where(access_token: token).first

  	api_key.access_token = ''
  	api_key.expires_at = Time.now

  	if api_key.save
  		render json: {}, status: 200
  	else
  		render json: {}, status: 422
  	end
  end

end
