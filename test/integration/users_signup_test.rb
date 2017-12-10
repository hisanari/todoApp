require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  test 'ユーザー登録失敗' do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: {
        user: {
          email: '',
          password: 'foo',
          password_confirmation: 'bar'
        }
      }
    end
    assert_template 'devise/registrations/new'
  end

  test 'ユーザー登録成功' do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: {
        user: {
          email: 'foobar@sample.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
