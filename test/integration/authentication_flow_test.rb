require 'test_helper'

class AuthenticationFlowTest < ActionDispatch::IntegrationTest
  test 'successfully redirect  to xing api' do
    get root_url
    assert_response :success
    get xing_authenticate_path
    assert_response :redirect
    assert_match /https:\/\/api.xing.com\/v1\/authorize/, @response.redirect_url
    assert_response :redirect
  end
end
