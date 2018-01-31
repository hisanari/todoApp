# ユーザー
User.create!(
  email: 'foobar@example.com',
  password: 'foobar',
  password_confirmation: 'foobar'
)
# タスクリスト
4.times do |i|
  title = "タスクリスト_#{i}"
  TaskList.create!(
    title: title,
    user_id: 1
  )
end
# Todo
3.times do |i|
  (1..3).each do |id|
    item = "やること_#{i}"
    limit = Time.zone.today + rand(1..7)
    Todo.create!(
      item: item,
      todo_limit: limit,
      status: 0,
      task_list_id: id
    )
  end
end
