class TaskListsController < ApplicationController
  before_action :authenticate_user!
  before_action :exists_tasklist, only: [:destroy]

  # POST /user/task_list
  def create
    tasklists = current_user.task_lists
    @new_tasklist = tasklists.build(tasklist_params)

    if @new_tasklist.save
      redirect_to users_path, notice: '新しいタスクリストが作成されました'
    else
      @task_lists = tasklists.includes(:todos).created_latest
      @latest_todos = Todo.user_todos(tasklists.ids).latest_todos
      render 'users/show'
    end
  end

  # DELETE /user/task_list/id
  def destroy
    @tasklist.destroy
    redirect_to users_path, alert: '削除しました。'
  end

  private

  def tasklist_params
    params.require(:task_list).permit(:title)
  end

  def exists_tasklist
    @tasklist = current_user.task_lists.find_by(id: params[:id])
    redirect_to users_path, alert: '存在しないか、権限がありません。' if @tasklist.nil?
  end
end
