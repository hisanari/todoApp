require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'user@exsample.com', password: 'foobar')
  end

  test '登録成功' do
    assert @user.valid?
  end

  test '名前が空で失敗' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'パスワードが空で失敗' do
    @user.password = '     '
    assert_not @user.valid?
  end

  test 'メールアドレスが被ってない' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end
