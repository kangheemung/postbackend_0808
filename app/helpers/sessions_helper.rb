module SessionsHelper
  def login(user)
    session[:id] = user.id
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id] && User.exists?(session[:id])
  end
end
