# ページごとにタイトルを返す
module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Todoアプリ'
    if page_title.empty?
      base_title
    else
      page_title + '|' + base_title
    end
  end

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

end
