
  class ApplicationController < ActionController::Base
    include SessionsHelper      
    include ActionController::Cookies
  
    rescue_from AuthenticationError, with: :render_unauthorized_error
    #protect_from_forgery with: :exception

    def render_unauthorized_error
      render json: { message: 'unauthorized' }, status: :unauthorized
    end
 
  

    helper_method :login!, :current_user
    
  end
  