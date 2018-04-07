module TodosHelper
  # Todoのstatusの状態によってボタンを変える
  def button_status(todo)
    case todo.status
    when 'before_work'
      link_to('完了にする',
              task_list_status_path(todo.task_list.id, todo.id),
              method: :put,
              class: 'btn btn-block btn-success')
    when 'done'
      button_tag('完了済', class: 'btn btn-block disabled')
    when 'expired'
      button_tag('期限切れ', class: 'btn btn-block disabled')
    end
  end

  # Todoのstatusによってiconを変える
  def icon_status(status)
    case status
    when 'done'
      content_tag(:span, '',
                  class: ['glyphicon', 'glyphicon-ok', 'text-success'])
    when 'expired'
      content_tag(:span, '',
                  class: ['glyphicon', 'glyphicon-flash', 'text-danger'])
    end
  end
end
