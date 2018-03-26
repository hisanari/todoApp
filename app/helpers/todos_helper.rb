module TodosHelper
  # Todoのstatusの状態によってボタンを変える
  def button_status(status)
    case status
    when 'before_work'
      '完了'
    when 'done'
      '未完了'
    when 'expired'
      '期限切れ'
    end
  end
end
