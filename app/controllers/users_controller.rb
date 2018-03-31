class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user_tasklists = current_user.task_lists
    @task_lists = user_tasklists.includes(:todos).created_latest
    @new_tasklist = user_tasklists.build
    @latest_todos = Todo.user_todos(user_tasklists.ids).latest_todos
  end
end
