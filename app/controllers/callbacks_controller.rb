class CallbacksController < ApplicationController

  def twitter
    user = User.find_or_create_with_twitter request.env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to home_path, notice: "Thank you for signing in with Twitter!"
    # render json: request.env['omniauth.auth']
  end

  def facebook
    user              = User.find_or_create_with_facebook request.env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to home_path, notice: "Thank you for signing in with Facebook!"
    # render json: request.env['omniauth.auth']
  end

  def google_oauth2
    user              = User.find_or_create_with_google_oauth2 request.env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to home_path, notice: "Thank you for signing in with Google!"
    # render json: request.env['omniauth.auth']
  end

end
