class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        access_token = token_creator(user)
      render json: { access_token: access_token }, status: :ok
    else
      # Authentication failed
      render json: { errors: ['Invalid email or password']}, status: :unprocessable_entity
    end
  end
end
