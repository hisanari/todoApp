module Todos
  class DoneAllTodosController < ApplicationController
    before_action :authenticate_user!

    # /user/done_all_todos
    def index
      tasklist_id = TaskList.where(user_id: current_user.id).ids
      todos = Todo.includes(:task_list).where(task_list_id: tasklist_id)
      @done_todos = todos.search_done.page(params[:page]).per(6)
    end
  end
end
