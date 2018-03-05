class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @task_lists = TaskList.where(user_id: current_user.id).created_latest
    @new_tasklist = current_user.task_lists.build
    @latest_todos = Todo.where(
      task_list_id: current_user.task_lists.ids
    ).limit(5).order(created_at: :DESC)
  end
end
