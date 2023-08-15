class SessionsController < ApplicationController
  include Authenticatable
  after_action :csrf_token,only: [:create, :update]
  def logged_in
    if @current_user
      render json: { logged_in: true, user: current_user }
    else
      render json: { logged_in: false, message: 'ユーザーが存在しません' }
    end
  end
  def csrf_token
    render json: { csrfToken: form_authenticity_token }
  end
  def login
    payload = {
      iss: "example_app", # JWTの発行者
      sub: user.id, # JWTの主体
      exp: (DateTime.current + 14.days).to_i # JWTの有効期限
    }

    rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))

    token = JWT.encode(payload, rsa_private, 'RS256')

    cookies.signed[:token] = {
      value: token,
      httponly: true,
      expires: 14.days.from_now
    }

    render json: { logged_in: true, user: current_user }
  end

  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
