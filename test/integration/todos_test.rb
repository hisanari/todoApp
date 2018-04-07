require 'test_helper'

class TodosTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @shukudai = task_lists(:shukudai)
    @math = todos(:math)
    @english = todos(:english)
  end

  test 'ログインからtodoの一覧表示、作成、更新、削除' do
    # ログインする
    sign_in @user
    visit users_path
    assert_equal current_path, users_path
    # todoの詳細リンク
    within find("#tasklist-#{@shukudai.id}") do
      click_link '見る'
    end
    assert_equal current_path, task_list_todos_path(@shukudai)
    assert page.has_content? @math.item
    # Todoの作成が失敗する
    fill_in 'todo_item', with: ''
    find('input[name="commit"]').click
    assert page.has_content? 'やることが入力されていません。'
    fill_in 'todo_item', with: 'a' * 21
    find('input[name="commit"]').click
    assert page.has_content? 'やることは20文字以下に設定して下さい。'
    # Todoの作成が成功する
    new_todo = 'foobar'
    fill_in 'todo_item', with: new_todo
    find('input[name="commit"]').click
    assert page.has_content? '新しいTodoが作成されました。'
    assert page.has_content? new_todo
    # Todoのボタンが状態によって変わる
    # Todoがbefore_workの時
    within find("#todo-#{@math.id}") do
      find_link '完了にする'
      click_link '完了にする'
    end
    # Todoがdoneの時
    within find("#todo-#{@math.id}") do
      find_button('完了済').has_css?('disabled')
    end
    # Todoが期限切れの時
    within find("#todo-#{@english.id}") do
      find_button('期限切れ').has_css?('disabled')
    end
    # Todoを削除する
    click_on '削除する', match: :first
    assert page.has_content? '削除しました。'
    assert_not page.has_content? @english
  end
end
