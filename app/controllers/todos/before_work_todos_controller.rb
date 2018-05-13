module Todos
  class BeforeWorkTodosController < ApplicationController
    before_action :authenticate_user!

    # /user/before_work_todos
    def index
      tasklist_id = TaskList.where(user_id: current_user.id).ids
      todos = Todo.includes(:task_list).where(task_list_id: tasklist_id)
      @before_work_todos = todos.search_before_work.page(params[:page]).per(6)
    end
  end
end
