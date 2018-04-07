class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def show
    @task_lists = current_user.task_lists.includes(:todos).created_latest
    @new_tasklist = current_user.task_lists.build
    @latest_todos = Todo.user_todos(current_user.task_lists.ids).latest_todos
  end
end
