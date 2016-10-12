require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    session[:access_token] = XING_CONFIG['auth_token']
    session[:access_token_secret] = XING_CONFIG['access_token_secret']
    @profile = XingUtils.user_profile(session)
    @total, @load_more,  @contact_list, @page   = XingUtils.get_contact_list @profile[:id]
  end


  test 'profile should not be blank' do
    assert_equal @profile.blank?, false
  end

  test 'contact_page_loading_successfully' do
    get :contacts
    assert_response :success
  end
end
