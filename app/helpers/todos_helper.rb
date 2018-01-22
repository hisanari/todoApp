module TodosHelper
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
