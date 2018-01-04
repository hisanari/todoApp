require 'test_helper'

class TaskListTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    @tasklist = @user.task_lists.build(title: 'foobar')
  end

  test 'バリデーションに通る' do
    assert @tasklist.valid?
  end

  test 'タイトルが無いため、無効になる' do
    @tasklist.title = nil
    assert_not @tasklist.valid?
  end

  test 'user_idが無いため、無効になる' do
    @tasklist.user_id = nil
    assert_not @tasklist.valid?
  end

  test 'titleが20文字以上で、無効になる' do
    @tasklist.title = 'a' * 21
    assert_not @tasklist.valid?
  end

  test 'タスクリストが被ってない' do
    dup_task = @user.task_lists.build(title: 'foobar')
    @tasklist.save
    assert_not dup_task.valid?
  end
end
