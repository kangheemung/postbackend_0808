class ApplicationController < ActionController::Base
  def token_creator(user)
    data = {user_id: user.id}
    access_token = JWT.encode({data: data, exp: Time.current.since(1.day).to_i}, 'super_strong_secret')
  end
end
