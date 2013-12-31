class ApplicationController < ActionController::API

	before_filter :cors_set_access_control_headers

	# CORS preflight headers
  def cors_preflight
  	# Change origin to production domains
  	puts "CORS preflight"
  	headers['Access-Control-Allow-Origin'] = 'http://localhost:8888'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Accept, Content-Type, Origin, X-ACCESS-TOKEN'
  end

	protected

	# Returns 401 if the user isn't authorized
	def ensure_authenticated_user
    head :unauthorized unless current_user
  end

  # Returns 401 if the user isn't an admin
  def ensure_admin_user
    head :unauthorized unless current_user.admin
  end

	# Returns the user belonging to the access token
	def current_user
    api_key = ApiKey.where(access_token: token).first

    if api_key && !api_key.is_expired && !api_key.is_locked
      return api_key.user
    else
      return nil
    end
  end

	# Grabs the access token from the header
	def token
		access_token = request.headers["X-ACCESS-TOKEN"]

		# allows tests to pass
		access_token ||= request.headers["rack.session"].try(:[], 'X-ACCESS-TOKEN')

		if access_token.present?
			access_token
		else
			nil
		end
	end

	# CORS headers
	def cors_set_access_control_headers
		# Change origin to production domains
    headers['Access-Control-Allow-Origin'] = 'http://localhost:8888'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = '172800'
  end

end
