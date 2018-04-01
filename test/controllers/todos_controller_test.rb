require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @task = task_lists(:shukudai)
    @todo = todos(:math)
  end

  test 'index表示できる' do
    sign_in @user
    get task_list_todos_path(@task)
    assert_response :success
    assert_template :index, partial: '_todo'
  end

  test 'index表示、ログインしていない時は、login pageへ' do
    get task_list_todos_path(@task)
    assert_redirected_to new_user_session_path
  end

  test 'postできる' do
    sign_in @user
    assert_difference 'Todo.count', 1 do
      post task_list_todos_path(@task), params: {
        todo: {
          item: 'foobar',
          todo_limit: Time.zone.today
        }
      }
    end
    assert_redirected_to task_list_todos_path
  end

  test 'ログインしていない時は、postできない(login pageへ)' do
    assert_no_difference 'Todo.count' do
      post task_list_todos_path(@task), params: {
        todo: {
          item: 'foobar',
          todo_limit: Time.zone.today
        }
      }
    end
    assert_redirected_to new_user_session_path
  end

  test 'destroyできる' do
    sign_in @user
    assert_difference 'Todo.count', -1 do
      delete task_list_todo_path(@task, @todo)
    end
    assert_redirected_to task_list_todos_path
  end

  test 'ログインしてない時は、destroyできない(login page()へ)' do
    assert_no_difference 'Todo.count' do
      delete task_list_todo_path(@task, @todo)
    end
    assert_redirected_to new_user_session_path
  end

  test '他のユーザーのやることファイルページにアクセスするとリダイレクトされる' do
    sign_in @user
    @shopping = task_lists(:shopping)
    get task_list_todos_path(@shopping)
    assert_redirected_to users_path
    assert_equal '存在しないか、権限がありません。', flash[:alert]
  end

  test '存在しないやることファイルにアクセスするとリダイレクトされる' do
    sign_in @user
    get task_list_todos_path(10)
    assert_redirected_to users_path
    assert_equal '存在しないか、権限がありません。', flash[:alert]
  end
end
