require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
  end

  test 'ログイン失敗' do
    visit new_user_session_path
    fill_in 'user_email', with: ''
    fill_in 'user_password', with: ''
    find('input[name="commit"]').click
    assert page.has_content? 'メールアドレスかパスワードが違います。'
    visit new_user_session_path
    assert_not page.has_content? 'メールアドレスかパスワードが違います。'
  end

  test 'ログイン、ログアウトできる' do
    visit new_user_session_path
    email = @user.email
    fill_in 'user_email', with: email
    fill_in 'user_password', with: 'password'
    find('input[name="commit"]').click
    assert_equal current_path, users_path
    assert page.has_content? 'ログインしました。'
    visit users_path
    assert_not page.has_content? 'ログインしました。'
    click_on 'ログアウト'
    assert_equal current_path, root_path
    assert page.has_content? 'ログアウトしました。'
  end

  test 'ログイン前にユーザーページにはアクセスできない' do
    visit users_path
    assert_equal current_path, new_user_session_path
    assert page.has_content? '続けるには、ログインまたは登録（サインアップ）が必要です。'
  end
end
