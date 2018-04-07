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
    expect = link_to('完了にする',
                     task_list_status_path(@math.task_list.id, @math.id),
                     method: :put,
                     class: 'btn btn-block btn-success')
    assert_equal(button_status(@math), expect)
    @math.status = 'done'
    expect = button_tag('完了済', class: 'btn btn-block disabled')
    assert_equal(button_status(@math), expect)
    @math.status = 'expired'
    expect = button_tag('期限切れ', class: 'btn btn-block disabled')
    assert_equal(button_status(@math), expect)
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
