class XingController < ApplicationController

  skip_before_filter :authenticate_session

  # this function will be used for the redirection to xing authentication url
  def authenticate
    callback_url = "http://#{request.host_with_port}/xing/authenticated_result"
    authenticated_url = XingUtils.get_authentication_url callback_url, session
    redirect_to authenticated_url
  end

  # after successfull or fail authentication from xing, user will be redirected to this url.
  # on successful return it will generate access token and access secret for user
  # for failure case, user will be redirected to root url

  def authenticated_result

    unless params[:oauth_verifier].blank?
      request_token, request_token_secret = session[:request_token], session[:request_token_secret]
      response = XingApi::Client.new.get_access_token(params[:oauth_verifier], request_token: request_token, request_token_secret: request_token_secret)
      session[:access_token] = response[:access_token]
      session[:access_token_secret] = response[:access_token_secret]
      redirect_to users_contacts_path
    else
      flash[:warning] = translate('warning.invalid_authentication')
      redirect_to root_path
    end

  end
end
