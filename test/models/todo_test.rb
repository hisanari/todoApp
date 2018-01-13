require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  def setup
    @todo = todos(:math)
  end

  test 'バリデーションが通る' do
    assert @todo.valid?
  end

  test 'itemが無いと失敗する' do
    @todo.item = nil
    assert_not @todo.valid?
  end

  test 'limitが無いと失敗する' do
    @todo.todo_limit = nil
    assert_not @todo.valid?
  end

  test 'statusがないと失敗する' do
    @todo.status = nil
    assert_not @todo.valid?
  end

  test 'itemが20文字以上で失敗する' do
    @todo.item = 'a' * 21
    assert_not @todo.valid?
  end
end
