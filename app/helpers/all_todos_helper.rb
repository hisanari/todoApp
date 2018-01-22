module AllTodosHelper
  def todo_status_for_css(todo)
    case todo.status
    when 'before_work'
      'primary'
    when 'done'
      'success'
    when 'expired'
      'warning'
    end
  end
end
