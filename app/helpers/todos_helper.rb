module TodosHelper
  # Todoのstatusの状態によって文章を変える
  def todo_status(todo)
    case todo.status
    when 'before_work'
      'まだ完了していません'
    when 'done'
      "完了しています。(#{todo.updated_at.strftime('%Y/%m/%d')})"
    when 'expired'
      '期限切れです。。。。'
    end
  end

  # Todoのstatusの状態によってボタンを変える
  def button_status(status)
    case status
    when 'before_work'
      '完了にする'
    when 'done'
      '未完了にする'
    when 'expired'
      '期限切れです。。。。'
    end
  end
end
