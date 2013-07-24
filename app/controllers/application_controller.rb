class ApplicationController < ActionController::API

	protected

	# Returns 401 if the user isn't authorized
	def ensure_authenticated_user
    head :unauthorized unless current_user
  end

	# Returns the user belonging to the access token
	def current_user
    api_key = ApiKey.active.where(access_token: token).first

    if api_key
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
		# prepend_before_filter :get_api_key
  # 	# do not use CSRF for CORS options
	 #  skip_before_filter :verify_authenticity_token, :only => [:options]
	 #  before_filter :cors_set_access_control_headers

		# def cors_set_access_control_headers
		# 	puts request.headers["HTTP_ORIGIN"]

		# 	# remove_keys = %w(X-Frame-Options X-XSS-Protection X-Content-Type-Options X-UA-Compatible)
		# 	# headers.delete_if{|key| remove_keys.include? key}

	 #    headers['Access-Control-Allow-Origin'] = 'http://localhost:8888'
	 #    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
	 #    headers['Access-Control-Allow-Headers'] = '*'
	 #    headers['Access-Control-Expose-Headers'] = 'ETag'
	 #    headers['Access-Control-Allow-Credentials'] = 'true'
	 #    headers['Access-Control-Max-Age'] = '0'
	 #  end

	 #  def cors_preflight
	 #  	puts "setting option headers"
	 #  	headers['Access-Control-Allow-Origin'] = '*'
	 #    headers['Access-Control-Allow-Methods'] = 'GET, POST'
	 #    headers['Access-Control-Allow-Headers'] = 'Accept, Authorization, Content-Type, Origin'
	 #    headers['Access-Control-Allow-Credentials'] = 'true'
	 #    headers['Access-Control-Max-Age'] = '0'
	 #    # render :text => '', :content_type => 'text/plain'
	 #  end

	  # # Grabs the API key from either the header or the url
	  # def get_api_key
	  #   if api_key = params[:api_key].blank? && request.headers["X-API-KEY"]
	  #     params[:api_key] = api_key
	  #   end
	  # end

end
