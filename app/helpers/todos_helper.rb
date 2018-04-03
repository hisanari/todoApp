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

  # Todoのstatusによってiconを変える
  def icon_status(status)
    case status
    when 'done'
      content_tag(:span, '',
                  class: ['glyphicon', 'glyphicon-ok', 'text-success'])
    when 'expired'
      content_tag(:span,
                  '',
                  class: ['glyphicon', 'glyphicon-flash', 'text-danger'])
    end
  end
end
