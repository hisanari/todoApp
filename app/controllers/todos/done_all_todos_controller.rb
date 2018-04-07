module Todos
  class DoneAllTodosController < ApplicationController
    before_action :authenticate_user!

    # /user/done_all_todos
    def index
      tasklist_id = TaskList.where(user_id: current_user.id).ids
      @done_todos = Todo.includes(:task_list).where(
        task_list_id: tasklist_id
      ).search_done
    end
  end
end
