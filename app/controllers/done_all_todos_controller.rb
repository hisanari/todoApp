class DoneAllTodosController < ApplicationController
  before_action :authenticate_user!
  before_action :todo_limit_update

  def index
    tasklist_id = TaskList.where(user_id: current_user.id).ids
    @done_todos = Todo.where(task_list_id: tasklist_id).search_done
  end
end