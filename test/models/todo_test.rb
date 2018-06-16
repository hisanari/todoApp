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

  test '渡された値が同じならTrue,そうでないならFalse' do
    todo_limit = Time.now.tomorrow
    todo_params = { item: '数学', todo_limit: todo_limit.strftime('%Y-%m-%d') }
    assert @todo.params_equal?(todo_params)
  end
end
