require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    skip
    get users_show_url
    assert_response :success
  end

end
