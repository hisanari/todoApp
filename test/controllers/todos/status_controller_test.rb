require 'test_helper'

class Todos::StatusControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @todo = todos(:math)
  end

  test 'ログインしていない時は、ログインページヘ' do
    patch task_list_status_path(@todo.task_list.id, @todo)
    assert_redirected_to new_user_session_path
  end
end
