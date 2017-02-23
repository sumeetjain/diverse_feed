class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_twitter(auth_hash)
    session[:user_id] = user.id
  end

  def destroy
    session[:user_id] = nil
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
