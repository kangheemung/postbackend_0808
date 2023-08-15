class UsersController < ApplicationController
  include Authenticatable
  after_action :csrf_token,only: [:signup, :update]


  #before_action :authenticate_with_token!

  def new
    @user = User.new
    render json: { status: 'success', message: 'User signed up successfully' }
  end

  def signup
    @user = User.new(user_params)
    if @user.save
      login!
      render json: { status: "success", data: { id: @user } }, status: :created
    else
      render json: { status: "error", errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  
  def show
    # CookieからJWTを取得
    token = cookies[:token]

    # 秘密鍵の取得
    rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))

    # JWTのデコード。JWTからペイロードが取得できない場合は認証エラーにする
    begin
      decoded_token = JWT.decode(token, rsa_private, true, { algorithm: 'RS256' })
    rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
      return render json: { message: 'unauthorized' }, status: :unauthorized
    end

    # subクレームからユーザーIDを取得
    user_id = decoded_token.first["sub"]

    # ユーザーを検索
    user = AuthenticationService.authenticate_user_with_token!(cookies[:token])
    
    # userが取得できた場合はユーザー情報を返す、取得できない場合は認証エラー
    render json: {
      user: {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email
      }
    }, status: :ok
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      render json: { status: "success", data: { id: @user.id } }, status: :ok
    else
      render json: { status: "error", message: "User not found" }, status: :not_found
    end
  end
  def csrf_token
    render json: { csrfToken: form_authenticity_token }
  end
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
