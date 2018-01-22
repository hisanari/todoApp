require 'test_helper'

class ExpiredAllTodosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
  end

  test '登録しているすべてのやることが表示できる' do
    sign_in @user
    get expired_all_todos_path
    assert_response :success
    assert_template :index
  end

  test 'ログインしていないと見れない' do
    get expired_all_todos_path
    assert_redirected_to new_user_session_path
  end
end
