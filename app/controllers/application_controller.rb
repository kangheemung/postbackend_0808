class ApplicationController < ActionController::Base
  include SessionsHelper      
  include ActionController::Cookies
  # protect_from_forgery with: :exception  <- Comment out or remove this line
  rescue_from AuthenticationError, with: :render_unauthorized_error
  #protect_from_forgery with: :null_session
  def render_unauthorized_error
    render json: { message: 'unauthorized' }, status: :unauthorized
  end

  helper_method :login!, :current_user
end
