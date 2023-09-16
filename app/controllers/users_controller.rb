class UsersController < ApplicationController
    def create
        user = User.create(name: params[:name], 
                            email: params[:email],
                            password: params[:password],
                            password_confirmation: params[:password_confirmation])
       #user有効だったら
       if user.valid?
           data = {user_id: user.id}
           access_token = token_creator(user)
           render json:{ access_token: access_token }, status: :ok
       else
          render json: {errors: user.errors.full_messages},status: :unprocessable_entity
       end
    end
end
