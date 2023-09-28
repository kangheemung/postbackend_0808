class UsersController < ApplicationController
    def create
        user = User.create(name: params[:name], 
                            email: params[:email],
                            password: params[:password],
                            password_confirmation: params[:password_confirmation])
       #user有効だったら
       if user.valid?
           access_token = token_creator(user)
           render json:{ access_token: access_token }, status: :ok
       else
           render json: {errors: user.errors.full_messages},status: :unprocessable_entity
       end
    end
    def show
        auth_header =request.headers[:Authorization]
        return render json: {errors:['No auth token']} unless auth_header
        token = auth_header.split(" ")[1]#baearer token
        return render json: {errors: ['No auth token']} unless token
        
        payload,= JWT.decode(token,'super_strong_secret')
        user_id =payload['data']['user_id']
        user=User.find_by(id: user_id)
        return render json:{errors: ['Invalid token']} unless user
        
        render json: {user: {name: user.name, email: user.email}},status: :ok
        
    
    end
end
