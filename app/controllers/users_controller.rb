class UsersController < ApplicationController

  # Creating a user does not require you to be authenticated
  before_filter :ensure_authenticated_user, :only => [:show, :update]

  # Returns a specific user if authenticated
  def show
    render json: User.find(params[:id])
  end

  # Create a new user, no authentication required
  def create
  	user = User.create(user_params)

  	if user.new_record?
      render json: { errors: user.errors.messages }, status: 422
    else
      render json: user.find_api_key, status: 201
    end
  end

  # Update the logged in user profile
  def update
    user = User.find(params[:id])

    # require password to change account information
    if user && user.authenticate(user_params[:password])

      updatedParams = user_params

      updatedParams[:password] = updatedParams[:new_password]
      updatedParams.delete(:new_password)

      if user.update_attributes(updatedParams)
        render json: user, status: 200
      else
        render json: { errors: user.errors.messages }, status: 422
      end
    else
      render json: { errors: user.errors.messages }, status: 401
    end
  end

  private

  # Strong Parameters (Rails 4)
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :new_password, :password_confirmation)
  end
end
