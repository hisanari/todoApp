require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
  end

  test 'ログイン失敗' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: {
      session: {
        email: '',
        password: ''
      }
    }
    assert_not flash.empty?
    get new_user_session_path
    assert flash.empty?
  end

  test 'ログイン成功' do
    visit new_user_session_path
    email = @user.email
    fill_in 'user_email', with: email
    fill_in 'user_password', with: 'password'
    find('input[name="commit"]').click
    assert page.has_content?('ログインしました。')
    visit users_path
    assert_not page.has_content?('ログインしました。')
  end

  test 'ログインしないでユーザーページ' do
    visit users_path
    assert page.has_content?('続けるには、ログインまたは登録（サインアップ）が必要です。')
  end
end
