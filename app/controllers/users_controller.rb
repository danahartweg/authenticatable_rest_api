class UsersController < ApplicationController

	prepend_before_filter :get_api_key
  before_filter :authenticate_user!, :except => [:create, :new, :show]

end
