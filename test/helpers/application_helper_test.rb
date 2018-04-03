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

  test 'todoのステータスの文章ヘルパー' do
    assert_equal(todo_status_for_text(@math), 'まだ完了していません。')
    @math.status = 'done'
    assert_equal(
      todo_status_for_text(@math),
      "完了しています。(#{Time.zone.now.strftime('%Y/%m/%d')})"
    )
  end

  test 'TodoのステータスのCSSのためのヘルパー' do
    assert_equal(todo_status_for_css(@math), 'primary')
    @math.status = 'done'
    assert_equal(todo_status_for_css(@math), 'success')
    @math.status = 'expired'
    assert_equal(todo_status_for_css(@math), 'danger')
  end
end
