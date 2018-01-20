class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = Todo.where(task_list_id: params[:task_list_id]).order(:todo_limit)
    @new_todo = TaskList.find_by(id: params[:task_list_id]).todos.build
  end

  def create
    @new_todo = TaskList.find_by(
      id: params[:task_list_id]
    ).todos.build(todo_params)
    if @new_todo.save
      redirect_to task_list_todos_path, notice: '新しいTodoが作成されました。'
    else
      @todos = Todo.where(task_list_id: params[:task_list_id])
      render 'todos/index'
    end
  end

  def destroy
    Todo.find_by(id: params[:id]).destroy
    redirect_to task_list_todos_path, alert: '削除しました。'
  end

  private

  def todo_params
    params.require(:todo).permit(:item, :todo_limit)
  end
end