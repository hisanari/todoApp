require 'test_helper'

class SearchPagesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @tasklist_shukudai = task_lists(:shukudai)
    @tasklist_kaji = task_lists(:kaji)
    @math = todos(:math)
  end

  test '検索機能' do
    sign_in @user
    visit users_path
    click_link '検索'
    assert_equal current_path, search_pages_path
    assert page.has_content? @tasklist_shukudai.title
    assert page.has_content? @tasklist_kaji.title
    assert page.has_content? @math.item
    fill_in 'q[title_or_todos_item_cont]', with: '国語'
    find('input[name=commit]').click
    assert page.has_content? @tasklist_shukudai.title
    assert page.has_content? '数学'
    assert_not page.has_content? @tasklist_kaji.title
  end
end
