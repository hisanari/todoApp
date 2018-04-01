require 'test_helper'

class TasklistTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @tasklist_shukudai = task_lists(:shukudai)
    @tasklist_kaji = task_lists(:kaji)
  end

  test 'タスクリストを作成、削除できる' do
    # ログインする
    sign_in @user
    visit users_path
    assert_equal current_path, users_path
    assert page.has_content? @tasklist_shukudai.title
    assert page.has_content? @tasklist_kaji.title
    # タスクリストの作成が失敗する
    fill_in 'task_list_title', with: ''
    find('input[name="commit"]').click
    assert page.has_content? 'タスクリスト名が入力されていません。'
    fill_in 'task_list_title', with: 'a' * 21
    find('input[name="commit"]').click
    assert page.has_content? 'タスクリスト名は20文字以下に設定して下さい。'
    fill_in 'task_list_title', with: '宿題'
    find('input[name="commit"]').click
    assert page.has_content? 'タスクリスト名は既に使用されています。'
    # タスクリストの作成が成功する
    new_task = 'foobar'
    fill_in 'task_list_title', with: new_task
    find('input[name="commit"]').click
    assert page.has_content? '新しいタスクリストが作成されました'
    assert page.has_content? new_task
    # タスクリストを削除する
    click_on '削除する', match: :first
    assert_not page.has_content? '宿題'
    assert page.has_content? '削除しました。'
  end
end
