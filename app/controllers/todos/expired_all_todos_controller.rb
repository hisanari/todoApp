class Todos::ExpiredAllTodosController < ApplicationController
  before_action :authenticate_user!

  # /user/expired_all_todos
  def index
    tasklist_id = TaskList.where(user_id: current_user.id).ids
    @expired_todos = Todo.includes(:task_list).where(task_list_id: tasklist_id).search_expired
  end

end
