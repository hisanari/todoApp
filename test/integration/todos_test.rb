require 'test_helper'

class TodosTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @shukudai = task_lists(:shukudai)
    @kaji = task_lists(:kaji)
    @math = todos(:math)
    @english = todos(:english)
    # ログインする
    sign_in @user
  end

  test 'ログインからtodoの一覧表示' do
    visit users_path
    assert_equal current_path, users_path
    # todoの詳細リンク
    within find("#tasklist-#{@shukudai.id}") do
      click_link '見る'
    end
    assert_equal current_path, task_list_todos_path(@shukudai)
    assert page.has_content? @math.item
    assert page.has_css? 'ul.pagination'
  end

  test 'todoの作成と失敗' do
    visit users_path
    assert_equal current_path, users_path
    within find("#tasklist-#{@shukudai.id}") do
      click_link '見る'
    end
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
  end

  test 'todoの更新と状態' do
    visit users_path
    assert_equal current_path, users_path
    within find("#tasklist-#{@shukudai.id}") do
      click_link '見る'
    end
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
  end

  test 'todoの編集' do
    Capybara.default_driver = :poltergeist
    visit task_list_todos_path(@shukudai)
    within find("#todo-#{@math.id}") do
      find_link('編集する').click
    end
    # バリデーションが表示される
    assert page.has_content? 'やることを編集する'
    within find("#edit_todo_#{@math.id}") do
      fill_in 'todo_item', with: ''
      find('input[name=commit]').click
      assert page.has_content? 'やることが入力されていません。'
      fill_in 'todo_todo_limit',	with: ''
      find('input[name=commit]').click
      assert page.has_content? '期限が入力されていません。'
      # 編集ができる
      fill_in 'todo_item', with: 'すうがく'
      fill_in 'todo_todo_limit', with: Time.now.strftime('%Y-%m-%d')
      find('input[name=commit]').click
    end
    # flashが表示されて、変更内容が反映されている
    assert page.has_content? '変更されました。'
    assert page.has_content? 'すうがく'
    # 完了済みのTodoを編集、内容に変更がある場合は未完了にステータスが反映されている
    within find("#todo-#{@math.id}") do
      click_link '完了にする'
      page.has_content? '完了済'
      find_link('編集する').click
    end
    within find("#edit_todo_#{@math.id}") do
      fill_in 'todo_item', with: '数学'
      find('input[name=commit]').click
    end
    within find("#todo-#{@math.id}") do
      page.has_content? '完了にする'
    end
    # 完了済みのTodoを編集、変更がない場合は、todoステータスは未完了のまま
    within find("#todo-#{@math.id}") do
      click_link '完了にする'
      page.has_content? '完了済'
      find_link('編集する').click
    end
    within find("#edit_todo_#{@math.id}") do
      find('input[name=commit]').click
    end
    within find("#todo-#{@math.id}") do
      page.has_content? '完了済'
    end
    # タスクリストファイルが移動できている
    visit task_list_todos_path(@kaji)
    assert_not page.has_content? @english.item
    visit task_list_todos_path(@shukudai)

    within find("#todo-#{@english.id}") do
      find_link('編集する').click
    end
    within find("#edit_todo_#{@english.id}") do
      find("option[value='#{@kaji.id}']").select_option
      find('input[name=commit]').click
    end
    visit task_list_todos_path(@kaji)
    page.has_content? @english.item
  end

  test 'todoの削除' do
    visit users_path
    assert_equal current_path, users_path
    within find("#tasklist-#{@shukudai.id}") do
      click_link '見る'
    end
    # Todoを削除する
    click_on '削除する', match: :first
    assert page.has_content? '削除しました。'
    assert_not page.has_content? @english
  end
end
