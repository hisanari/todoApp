require 'test_helper'

class AllTodosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
  end

  test '登録しているすべてのやることが表示できる' do
    sign_in @user
    get all_todos_path
    assert_response :success
    assert_template :index, partial: '_all_todos'
  end

  test 'ログインしていないと見れない' do
    get all_todos_path
    assert_redirected_to new_user_session_path
  end
end
