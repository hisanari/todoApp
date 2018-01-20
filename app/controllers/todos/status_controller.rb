class Todos::StatusController < ApplicationController
  before_action :authenticate_user!

  def update
    # Todoのステータスを切り替える
    todo = Todo.find_by(id: params[:id])
    if todo.status == 'before_work'
      todo.update(status: 1)
    else
      todo.update(status: 0)
    end

    redirect_to task_list_todos_path(task_list_id: todo.task_list.id)
  end
end
