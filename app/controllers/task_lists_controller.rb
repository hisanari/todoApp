class TaskListsController < ApplicationController
  before_action :authenticate_user!
  before_action :todo_limit_update

  def create
    @new_tasklist = current_user.task_lists.build(tasklist_params)
    if @new_tasklist.save
      redirect_to users_path, notice: '新しいタスクリストが作成されました'
    else
      @task_lists = current_user.task_lists.created_latest
      @latest_todos = Todo.where(
        task_list_id: current_user.task_lists.ids
      ).limit(5).order(created_at: :DESC)
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
