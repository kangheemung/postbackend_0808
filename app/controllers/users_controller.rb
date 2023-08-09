class UsersController < ApplicationController
  def new
    @user=User.new
  end
  def signup
    @user = User.new(users_params)
    p "================="
    p params
    p "================="

        if @user.save
          log_in(user)
            render json: { status: :created, user: @user }
        else
            render json: { status: 500 }
        end
  end
  


  def show
  end

  def edit
  end
  private

  def users_params
      params.require(:user).permit(:name,:email, :password, :password_confirmation)
  end
 
  
end
