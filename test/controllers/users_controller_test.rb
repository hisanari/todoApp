require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
  end
  test 'should get user path' do
    sign_in @user
    get users_path
    assert_response :success
  end
end
