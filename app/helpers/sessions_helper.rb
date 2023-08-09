module SessionsHelper
      def login!
        session[:user_id] = @user.id
      end
      def logged_in?(user)
         !current_user.nil?
      end

      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
