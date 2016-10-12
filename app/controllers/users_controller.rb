class UsersController < ApplicationController

  def contacts
    begin
      @profile = XingUtils.user_profile(session)
      @total, @load_more,  @contact_list, @page   = XingUtils.get_contact_list @profile[:id], params

    rescue XingApi::InvalidOauthTokenError
      session.delete(:access_token)
      session.delete(:access_token_secret)
      flash[:warning] = t('warning.auth_token_expired')
      redirect_to root_path
    rescue XingApi::RateLimitExceededError
      flash[:warning] = t('rate_limit_exceeded')
      redirect_to root_path
    rescue XingApi::Error => e
      logger.error (e.message)
      logger.error (e.backtrace.inspect)
    end
  end
end

