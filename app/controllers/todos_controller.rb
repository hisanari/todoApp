class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasklist = current_user.task_lists.find_by(id: params[:task_list_id])
    @todos = @tasklist.todos.order(:todo_limit)
    @new_todo = @tasklist.todos.build
  end

  def create
    @tasklist = current_user.task_lists.find_by(id: params[:task_list_id])
    @todos = @tasklist.todos.order(:todo_limit)
    @new_todo = @tasklist.todos.build(todo_params)

    if @new_todo.save
      redirect_to task_list_todos_path, notice: '新しいTodoが作成されました。'
    else
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
