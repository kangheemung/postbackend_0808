class SessionsController < ApplicationController
  include Authenticatable
  after_action :csrf_token ,only: [:logout,:logged_in]
  skip_before_action :verify_authenticity_token, only: [:login]

  def logged_in
    if logged_in?
      p "================logged_in====="
      p params
      p '====================='
      render json: { user: current_user }
    else
      render json: {}, status: :bad_request
    end
  end

  def login
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #login(user)
      session[:user_id] = user.id
      render json: { status: "success", logged_in: true, id: user.id, message: 'Login success' }
    else
      render json: { status: "error", errors: ["Invalid email or password"] }, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Logged out successfully" }
    return
  end

  def csrf_token
    response.headers['X-CSRF-Token'] = form_authenticity_token
    head :ok
  end
end
