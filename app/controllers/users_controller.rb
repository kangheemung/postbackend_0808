class UsersController < ApplicationController
  def new
    @user=User.new
    render json: { status: 'success', message: 'User signed up successfully' }
  end
  def signup
    @user = User.new(user_params)
    p "================="
    p params
    p "================="

    if @user.save
      user_id = @user.id
      p "=========@user========"
      @user.errors.full_messages
      p "================="
      render json: { status: "success", data: { id: user_id } }, status: :created

    else  p "=========else========"
      @user.errors.full_messages
      p "================="
      render json: { status: "error", errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def show
    @user = User.find_by(id: params[:id])
  
    if @user
      render json: @user
    else
      render json: { status: "error", message: "User not found" }, status: :not_found
    end
  end
  end

  



  def edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
