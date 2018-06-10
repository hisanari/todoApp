module Todos
  class AllTodosController < ApplicationController
    before_action :authenticate_user!

    # /user/all_todos
    def index
      tasklist_id = TaskList.where(user_id: current_user.id).ids
      @all_todos = Todo.includes(:task_list).where(task_list_id: tasklist_id).order(:created_at).page(params[:page]).per(6)
    end
  end
end
