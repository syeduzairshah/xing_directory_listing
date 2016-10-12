require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test 'page is loading correctly' do
    get :index
    assert_response :success
  end
end
