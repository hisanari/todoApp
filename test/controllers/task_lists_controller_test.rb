require 'test_helper'

class TaskListsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @tasklist = task_lists(:shukudai)
  end

  test 'タスクリストの追加はログインしていないとログインページヘ' do
    assert_no_difference 'TaskList.count' do
      post task_lists_path, params: {
        tasklist: { title: 'foobar' }
      }
    end
    assert_redirected_to new_user_session_path
  end

  test 'タスクリストの削除はログインしていないとログインページヘ' do
    assert_no_difference 'TaskList.count' do
      delete task_list_path(@tasklist)
    end
    assert_redirected_to new_user_session_path
  end

  test '他のユーザーが削除できない' do
    sign_in(@user)
    # 他のユーザーが所持するタスク
    @shopping = task_lists(:shopping)
    assert_no_difference 'TaskList.count' do
      delete task_list_path(@shopping)
    end
    assert_redirected_to users_path
    assert_equal '存在しないか、権限がありません。', flash[:alert]
  end

  test 'ログインしていないまたは、ユーザー以外はeditにアクセスできない' do
    get edit_task_list_path(@tasklist), xhr: true
    assert_response 401
    sign_in(@user)
    # 他のユーザーが所持するタスク
    @shopping = task_lists(:shopping)
    get edit_task_list_path(@shopping), xhr: true
    assert_redirected_to users_path
    assert_equal '存在しないか、権限がありません。', flash[:alert]
  end

end
