require 'test_helper'

class SearchPagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
  end

  test '検索ページが表示できる' do
    sign_in @user
    get search_pages_path
    assert_response :success
    assert_template :index
  end

  test 'ログインしていないと見れない' do
    get search_pages_path
    assert_redirected_to new_user_session_path
  end
end
