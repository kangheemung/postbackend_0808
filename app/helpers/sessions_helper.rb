module SessionsHelper
    def login!
        session[:id] = @user.id
    end

    def current_user
        @current_user ||= User.find(session[:id]) if session[:id]
    end
end
