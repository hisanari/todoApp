class TaskListsController < ApplicationController
  before_action :authenticate_user!

  def create
    @new_tasklist = current_user.task_lists.build(tasklist_params)
    if @new_tasklist.save
      redirect_to users_path, notice: '新しいタスクリストが作成されました'
    else
      @tasklists = current_user.task_lists.all
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
