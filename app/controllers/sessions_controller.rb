class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_twitter(auth_hash)
    session[:user_id] = user.id
    redirect_to :root, notice: "Welcome!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: "You have been logged out."
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
