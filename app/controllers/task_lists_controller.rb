class TaskListsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_tasklists = current_user.task_lists
    @new_tasklist = user_tasklists.build(tasklist_params)

    if @new_tasklist.save
      redirect_to users_path, notice: '新しいタスクリストが作成されました'
    else
      @task_lists = user_tasklists.includes(:todos).created_latest
      @latest_todos = Todo.user_todos(user_tasklists.ids).latest_todos
      render 'users/show'
    end
  end

  def destroy
    current_user.task_lists.find_by(id: params[:id]).destroy
    redirect_to users_path, alert: '削除しました。'
  end

  private

  def tasklist_params
    params.require(:task_list).permit(:title)
  end
end
