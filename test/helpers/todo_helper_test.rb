require 'test_helper'

class TodoHelperTest < ActionView::TestCase
  include Devise::Test::IntegrationHelpers
  include TodosHelper

  def setup
    @user = users(:john)
    @shukudai = task_lists(:shukudai)
    @math = todos(:math)
  end

  test 'Todoのステータスのボタンのためのヘルパー' do
    assert_equal(button_status(@math.status), '完了')
    @math.status = 'done'
    assert_equal(button_status(@math.status), '未完了')
    @math.status = 'expired'
    assert_equal(button_status(@math.status), '期限切れ')
  end

  test 'Todoのステータスのアイコンのためのヘルパー' do
    @math.status = 'done'
    expect = content_tag(:span,
                         '',
                         class: ['glyphicon', 'glyphicon-ok', 'text-success'])
    assert_equal(icon_status(@math.status), expect)
    @math.status = 'expired'
    expect = content_tag(:span,
                         '',
                         class: ['glyphicon', 'glyphicon-flash', 'text-danger'])
    assert_equal(icon_status(@math.status), expect)
  end
end
