class AllTodosController < ApplicationController
  before_action :authenticate_user!

  def index
    tasklist_id = TaskList.where(user_id: current_user.id).ids
    @all_todos = Todo.where(task_list_id: tasklist_id).order(:created_at)
  end
end
