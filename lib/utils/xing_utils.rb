module XingUtils

  # it will be used to generate redirect url to xing api for authentication
  #input
  #    callback  - it will be used to redirect back to application after authentication
  #output
  #    redirection url of xing authentication

  def self.get_authentication_url(callback, session)
    response = XingApi::Client.new.get_request_token(callback)
    session[:request_token] = response[:request_token]
    session[:request_token_secret] = response[:request_token_secret]
    redirect_url = response[:authorize_url]
    redirect_url
  end


  # it will be used to configure global client object with outh tokens
  #input
  #    session  - it will pick values from session variables,
  #                for real time applicaiton we can store auth_token and secret in user object


  def self.configure_client(session)
    oauth_token, oauth_token_secret = session[:access_token], session[:access_token_secret]

    XingApi::Client.configure do |config|
      config.oauth_token = oauth_token
      config.oauth_token_secret = oauth_token_secret
    end
  end

  # it will be used to fetch user data from xing api
  #input
  #    session  - session variable contains authentication data
  #output
  #    user profile object from xing api

  def self.user_profile(session)
    configure_client(session)
    profile = nil
    user_response = XingApi::User.me
    profile = user_response[:users].first if user_response.has_key?(:users) && !user_response[:users].blank?
    profile
  end

  # it will be used to fetch user contact list
  #input
  #    user_id  - user id fetched from profile api
  #output
  #   user contact list

  def self.get_contact_list(user_id, params = {})
    page = params[:page].to_i || 0
    limit_per_page = 20
    offset = page * limit_per_page
    response = XingApi::Contact.list(user_id, user_fields: 'id,display_name,photo_urls,professional_experience', limit: limit_per_page, offset: offset )

    total_contacts = response[:contacts][:total]
    load_more = total_contacts > (limit_per_page * (page + 1))
    contact_list = response[:contacts][:users]
    return total_contacts, load_more, contact_list, page + 1

  end
end