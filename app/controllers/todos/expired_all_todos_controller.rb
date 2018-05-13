module Todos
  class ExpiredAllTodosController < ApplicationController
    before_action :authenticate_user!

    # /user/expired_all_todos
    def index
      tasklist_id = TaskList.where(user_id: current_user.id).ids
      todos = Todo.includes(:task_list).where(task_list_id: tasklist_id)
      @expired_todos = todos.search_expired.page(params[:page]).per(6)
    end
  end
end
