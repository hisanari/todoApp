module Todos
  class BeforeWorkTodosController < ApplicationController
    before_action :authenticate_user!

    # /user/before_work_todos
    def index
      tasklist_id = TaskList.where(user_id: current_user.id).ids
      @before_work_todos = Todo.includes(:task_list).where(
        task_list_id: tasklist_id
      ).search_before_work
    end
  end
end
