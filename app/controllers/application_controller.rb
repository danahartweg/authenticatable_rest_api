class ApplicationController < ActionController::API

	  before_filter :set_headers

	  private

	  def set_headers
	    if request.headers["HTTP_ORIGIN"]
	      headers['Access-Control-Allow-Origin'] = '*'
	      headers['Access-Control-Expose-Headers'] = 'ETag'
	      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
	      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
	      headers['Access-Control-Max-Age'] = '86400'
	    end
	  end

end
