namespace :todo_task do
  desc '期限をチェックする'
  task todo_limit_update: :environment do
    Todo.where(
      'todo_limit < ? and status != ?', Time.zone.today, 1
    ).update_all(status: 'expired')
  end
end
