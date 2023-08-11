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
        login!
      p "=========@user========"
      @user.errors.full_messages
      p "================="
      render json: { status: "success", data: @user }, status: :created
    else  p "=========else========"
      @user.errors.full_messages
      p "================="
      render json: { status: "error", errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def show
    @user = user.find(params[:id])
    render json: @user
  end

  



  def edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
