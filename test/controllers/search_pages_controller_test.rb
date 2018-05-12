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

  test 'タスクリストの検索結果がなくて、TODOの検索結果がある' do
    sign_in @user
    get search_pages_path, params: { q: '英語' }
    task_results = assigns[:task_results]
    assert task_results.empty?
    todo_results = assigns[:todo_results]
    assert_equal todos(:english), todo_results.first
    assert_select "div#todo-id-#{todos(:english).id}"
  end

  test 'タスクリストの検索結果があり、TODOの検索結果が無い' do
    sign_in @user
    get search_pages_path, params: { q: '家事' }
    assert_response :success
    task_results = assigns[:task_results]
    assert_equal task_lists(:kaji), task_results.first
    assert_select "div#result-id-#{task_lists(:kaji).id}"
    todo_results = assigns[:todo_results]
    assert todo_results.empty?
  end

  test 'ログインしていないと見れない' do
    get search_pages_path
    assert_redirected_to new_user_session_path
  end
end
