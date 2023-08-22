class SessionsController < ApplicationController
  include Authenticatable
  after_action :csrf_token, only: [:login, :logged_in,:csrf_token]
  skip_before_action :verify_authenticity_token, only: [:login,:logged_in]
 

  def logged_in
    if logged_in?
      p"================logged_in====="
      p params
      p'====================='
      render json: { user: current_user }
    else
      render json: {}, status: :bad_request
    end
  end

  def login
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
    login(user)
      render json: {status: create,
                    logged_in: ture,
                    id: user.id, 
                     message: 'Login success' }
    else
      render json: { status: "error", errors: ["Invalid email or password"] }, status: :unprocessable_entity
    end
  end

  def destroy
    forget(current_user)
    reset_session
  end

  def csrf_token
    response.headers['X-CSRF-Token'] = form_authenticity_token
    head :no_content
  end

end