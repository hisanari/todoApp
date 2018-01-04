class TaskListsController < ApplicationController
  before_action :authenticate_user!

  def create
    @new_tasklist = current_user.task_lists.build(tasklist_params)
    if @new_tasklist.save
      redirect_to users_path, notice: '作成できました！'
    else
      @all_tasklists = current_user.task_lists.all
      render 'users/show'
    end
  end

  def destroy
  end

  private

  def tasklist_params
    params.require(:task_list).permit(:title)
  end
end
