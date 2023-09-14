class UsersController < ApplicationController
  include Authenticatable
    def signup
        user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        if user.valid?#user有効だったら
          access_token =token_creator(user)
            render json: {access_token: access_token}, status: :ok
        else
            render json: {errors: user.errors.full_messages}, status: :ng
        end
    end

    def show
      auth_header = request.headers[:Authorization]
      return render json: {errors: ['No auth token']} unless auth_header
      token = auth_header.split(" ")[1] # Bearer token
      return render json: {errors: ['No auth token']} unless token

      payload, = JWT.decode(token, 'super_strong_secret')
      user_id = payload['data']['user_id']
      user = User.find_by(id: user_id)
      return render json: {errors: ['Invalid token']} unless user

      render json: {user: {name: user.name, email: user.email}}, status: :ok
  end
  
 

  def edit
    @user = User.find_by(id: params[:id])

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
end
