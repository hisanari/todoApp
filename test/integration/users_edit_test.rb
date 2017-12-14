require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
  end

  test 'ユーザー情報編集失敗' do
    sign_in @user
    get edit_user_registration_path
    assert_response :success
    assert_template 'devise/registrations/edit'
    email = 'foo@example.com'
    patch user_registration_path, params: {
      user: {
        email: email,
        password: '',
        password_confirmation: '',
        current_password: 'miss_password'
      }
    }
    assert_template 'devise/registrations/edit'
    @user.reload
    assert_not_equal email, @user.email
  end

  test 'ユーザー情報編集成功' do
    sign_in @user
    get edit_user_registration_path
    assert_response :success
    assert_template 'devise/registrations/edit'
    email = 'foo@example.com'
    patch user_registration_path, params: {
      user: {
        email: email,
        password: '',
        password_confirmation: '',
        current_password: 'password'
      }
    }
    follow_redirect!
    assert_template 'devise/registrations/edit'
    @user.reload
    assert_equal email, @user.email
  end
end
