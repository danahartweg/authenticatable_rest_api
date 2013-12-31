class UsersController < ApplicationController

  # creating a user doesn't require you to have an access token
  skip_before_filter :ensure_authenticated_user, :only => [:create]

  # Returns the authenticated user information
  def show
    render json: @currentUser
  end

  # Create a new user, no authentication required
  def create
    # deny user creation if a user is logged in
    if current_user
      render json: { errors: "You are currently logged in." }, status: 401
    else
      user = User.create(user_params)

      if !user.new_record?
        render json: user.find_api_key, status: 201
      else
        render json: { errors: user.errors.messages }, status: 422
      end
    end
  end

  # Update the authenticated user profile
  def update
    # require password to change account information
    if @currentUser && @currentUser.authenticate(user_params[:password])

      updatedParams = user_params

      updatedParams[:password] = updatedParams[:new_password]
      updatedParams.delete(:new_password)

      if @currentUser.update_attributes(updatedParams)
        head :no_content
      else
        render json: { errors: @currentUser.errors.messages }, status: 422
      end
    else
      render json: { errors: @currentUser.errors.messages }, status: 401
    end
  end

  private

  # Strong Parameters (Rails 4)
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :new_password, :password_confirmation)
  end
end
