class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def show
    user_task = current_user.task_lists
    @task_lists = user_task.includes(:todos).created_latest
    @new_tasklist = user_task.build
    @latest_todos = Todo.user_todos(user_task.ids).includes(:task_list).latest_todos
  end
end
