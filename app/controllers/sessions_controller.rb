class SessionsController < ApplicationController
  include Authenticatable
  include SessionsHelper  # Include the SessionsHelper module
  skip_before_action :verify_authenticity_token
  before_action :require_login, only: [:login]
  def logged_in
    if @current_user
      render json: { logged_in: true, user: current_user }
    else
      render json: { logged_in: false, message: 'ユーザーが存在しません' }
    end
  end

  def login
    if current_user.nil?
      render json: { logged_in: false, message: 'ユーザーが存在しません' }
    else
      payload = {}
      payload[:iss] = "example_app"
      payload[:sub] = current_user.id if current_user # Check if current_user exists
      payload[:exp] = (DateTime.current + 14.days).to_i
  
      rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))
  
      token = JWT.encode(payload, rsa_private, 'RS256')
  
      cookies.signed[:token] = {
        value: token,
        httponly: true,
        expires: 14.days.from_now
      }
  
      render json: { logged_in: true, user: current_user }
    end
  end
  

  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end

  def csrf_token
    render json: { csrf_token: form_authenticity_token }
  end
  
  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
  def require_login
    unless logged_in?
      redirect_to login_path, notice: 'Please log in to continue'
    end
  end
end
