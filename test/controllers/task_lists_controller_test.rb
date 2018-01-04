require 'test_helper'

class TaskListsControllerTest < ActionDispatch::IntegrationTest
  def setup
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
end
