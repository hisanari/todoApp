class Todos::AllTodosController < ApplicationController
  before_action :authenticate_user!

  # /user/all_todos
  def index
    tasklist_id = TaskList.where(user_id: current_user.id).ids
    @all_todos = Todo.includes(:task_list).where(task_list_id: tasklist_id).order(:created_at)
  end
end
