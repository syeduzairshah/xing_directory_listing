class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_session



  private
    def authenticate_session
      if session[:access_token].blank? || session[:access_token_secret].blank?
        flash[:warning] = translate('warning.invalid_authentication')
        redirect_to root_path
      end
    end
end
