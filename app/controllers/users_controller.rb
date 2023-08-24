class UsersController < ApplicationController
  include Authenticatable
  after_action :csrf_token, only: [:show,:update]
  skip_before_action :verify_authenticity_token, only: [:signup]

  def new
    @user = User.new
    render json: { status: 'ture', message: 'User signed up successfully' }
  end

  def signup
    user = User.new(user_params)
    if user.save
      login(user)
      return render json: { status: 'ture', logged_in: true,id: user.id,  message: 'Signup success' }
    else
      render json: { status: "error", errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    token = cookies[:token]

    if token.present?
      render json: { message: 'Unauthorized' }, status: :unauthorized
    else
      begin
        rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))
        decoded_token = JWT.decode(token, rsa_private, true, algorithm: 'RS256')
        user_id = decoded_token.first['sub']
        user = User.find_by(id: user_id)

        if user
          render json: {
            user: {
              id: user.id,
              name: user.name,
              email: user.email
            }
          }, status: :true
        else
          render json: { status: 'error', message: 'User not found' }, status: :not_found
        end
      rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
        render json: { message: 'Unauthorized' }, status: :unauthorized
      end
    end
  end

  def edit
    @user = User.find_by(id: params[:user_id])

    if @user
      render json: { status: 'success', data: { id: @user.id } }, status: :ok
    else
      render json: { status: 'error', message: 'User not found' }, status: :not_found
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      render json: { status: 'success', data: { id: @user.id } }, status: :ok
    else
      render json: { status: 'error', message: 'User not found' }, status: :not_found
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def csrf_token
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end
