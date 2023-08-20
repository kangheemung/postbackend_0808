class SessionsController < ApplicationController
  include Authenticatable
  after_action :csrf_token, only: [:login, :csrf_token]
  skip_before_action :verify_authenticity_token, only: [:login]
 

  def logged_in
    if logged_in?
      p"================logged_in====="
      p params
      p'====================='
      render json: { user: current_user }
    else
      render json: {}, status: :bad_request
    end
  end

  def login
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      
      render json: { id: user.id, status: 200, message: 'Login success' }
    else
      render json: { status: "error", errors: ["Invalid email or password"] }, status: :unprocessable_entity
    end
  end

  def destroy
    forget(current_user)
    reset_session
  end

  def csrf_token
    response.headers['X-CSRF-Token'] = form_authenticity_token
    head :no_content
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
