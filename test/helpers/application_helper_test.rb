require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @shukudai = task_lists(:shukudai)
    @math = todos(:math)
  end

  test 'タイトル表示ヘルパー' do
    assert_equal full_title, 'Todoアプリ'
    assert_equal full_title('Help'), 'Help|Todoアプリ'
  end

end
