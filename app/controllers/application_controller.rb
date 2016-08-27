class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    protected

    def authenticate_user!
        unless user_signed_in?
            respond_to do |format|
            format.html { redirect_to new_session_path, notice: "Please sign in!" }
            format.js do
                flash[:notice]   = "Please sign in!"
                render ajax_redirect_to(new_session_url)
                end
            end
        end
    end

    def user_signed_in?
        session[:user_id].present?
    end
    helper_method :user_signed_in?

    def current_user
        current_user ||= User.find session[:user_id] if user_signed_in?
    end
    helper_method :current_user

    def sign_in(user)
        session[:user_id] = user.id
    end

    def ajax_redirect_to(url)
        {js: "window.location.replace('#{url}')"}
    end

end
