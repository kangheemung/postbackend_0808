class SessionsController < ApplicationController
  include Authenticatable

  # Remove the after_action and protect_from_forgery callbacks
  after_action :csrf_token, only: [:logout, :logged_in, :destroy]
  skip_before_action :verify_authenticity_token, only: [:login, :destroy]

  def logged_in
    if @current_user
      p "================logged_in====="
      p params
      p '====================='
     # Call the login method from the SessionsHelper module
      render json: { logged_in: true,user: @current_user ,message: 'Login success' }
    else
      render json: { status: "error", errors: ["Invalid email or password"] }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      access_token = token_creator(user)
      render json: {access_token: access_token}, status: :ok
    else
      # Authentication failed
      render json: {errors: user.errors.full_messages}, status: :ng
    end
  end

  def destroy
    # Clear the session and JWT from headers
    response.headers.delete('Authorization')

    render json: { message: "Logged out successfully" }
  end



end
