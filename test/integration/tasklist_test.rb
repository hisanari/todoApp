require 'test_helper'

class TasklistTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @tasklist_shukudai = task_lists(:shukudai)
    @tasklist_kaji = task_lists(:kaji)
    # ログインする
    sign_in @user
  end

  test 'タスクリストを作成、削除できる' do
    visit users_path
    assert_equal current_path, users_path
    assert page.has_content? @tasklist_shukudai.title
    assert page.has_content? @tasklist_kaji.title
  end

  test 'タスクリストの作成' do
    visit users_path

    # タスクリストの作成が失敗する
    fill_in 'task_list_title', with: ''
    find('input[name="commit"]').click
    assert page.has_content? 'ファイル名が入力されていません。'
    fill_in 'task_list_title', with: 'a' * 21
    find('input[name="commit"]').click
    assert page.has_content? 'ファイル名は20文字以下に設定して下さい。'
    fill_in 'task_list_title', with: '宿題'
    find('input[name="commit"]').click
    assert page.has_content? 'ファイル名は既に使用されています。'
    # タスクリストの作成が成功する
    new_task = 'foobar'
    fill_in 'task_list_title', with: new_task
    find('input[name="commit"]').click
    assert page.has_content? 'ファイルが作成されました'
    assert page.has_content? new_task
  end

  test 'タスクリストの更新' do
    Capybara.default_driver = :poltergeist

    visit users_path

    # 更新できる
    assert_not page.has_content? '変更する'
    within find("#tasklist-#{@tasklist_shukudai.id}") do
      find_link('編集').click
    end
    assert page.has_content? '変更する'
    within find("#edit_task_list_#{@tasklist_shukudai.id}") do
      fill_in 'task_list_title', with: ''
      find('input[name="commit"]').click
      assert page.has_content? 'ファイル名が入力されていません '
      fill_in 'task_list_title', with: 'a' * 21
      find('input[name="commit"]').click
      assert page.has_content? 'ファイル名は20文字以下に設定して下さい。'
      edit_task = '課題'
      fill_in 'task_list_title', with: edit_task
      find('input[name="commit"]').click
    end
    assert page.has_content? '変更しました'
    assert page.has_content? '課題'
  end

  test 'タスクリストの削除' do
    visit users_path

    # タスクリストを削除する
    click_on '削除する', match: :first
    assert_not page.has_content? '課題'
    assert page.has_content? '家事'
    assert page.has_content? '削除しました。'
  end
end
