require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @task = task_lists(:shukudai)
  end

  test 'ログイン時には、index表示できる' do
    sign_in @user
    get task_list_todos_path(@task)
    assert_response :success
    assert_template :index, partial: '_todo'
  end

  test 'ログインじていない時は、login pageへ' do
    get task_list_todos_path(@task)
    follow_redirect!
    assert_template 'devise/sessions/new'
  end
end
