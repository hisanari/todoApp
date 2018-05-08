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

  test '検索できる' do
    sign_in @user
    get search_pages_path, params: { q: '家事' }
    assert_response :success
    # タスクリストの検索結果があり
    task_results = assigns[:task_results]
    assert_equal task_lists(:kaji), task_results.first
    # TODOの検索結果が無い
    todo_results = assigns[:todo_results]
    assert todo_results.empty?
    get search_pages_path, params: { q: '英語' }
    # タスクリストの検索結果がない
    task_results = assigns[:task_results]
    assert task_results.empty?
    # TODOの検索結果がある
    todo_results = assigns[:todo_results]
    assert_equal todos(:english), todo_results.first
  end

  test 'ログインしていないと見れない' do
    get search_pages_path
    assert_redirected_to new_user_session_path
  end
end
