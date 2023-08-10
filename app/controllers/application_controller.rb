class ApplicationController < ActionController::Base
    include SessionsHelper    
    skip_before_action :verify_authenticity_token
    helper_method :login!, :current_user
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
end
