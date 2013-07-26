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

    if user.update_attributes(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors.messages }, status: 422
    end
  end

  private

  # Strong Parameters (Rails 4)
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
